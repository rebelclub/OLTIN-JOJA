unit VolSN;

interface

uses
  Windows, SysUtils;

const
  VOLUME_SN_BUF_SIZE = 512;

type
  TVolumeSNBuf = array[0..VOLUME_SN_BUF_SIZE-1] of AnsiChar;

  TVolumeSN = class
  private
    hD: THandle;
    function DiskOpen( Vol: PChar ): Boolean;
    procedure DiskClose;
    function ReadSector ( var Buffer: TVolumeSNBuf ): Boolean;
    function WriteSector( var Buffer: TVolumeSNBuf ): Boolean;
  public
    function GetVolumeSN( Volume: string ): string;
    function SetVolumeSN( Volume: string; NewSN: DWORD ): Boolean; overload;
    function SetVolumeSN( Volume: string; NewSN: string ): Boolean; overload;
  end;

var
  VolumeSN: TVolumeSN;

implementation

{ TDisk }

type
  // Структура для сигнатуры загрузочной области
   TPartialBootSectorInfo = record
      Fs: LPSTR;         // Название файловой системы
      FsOffs: DWORD;     // Смещение системного имени в загрузочной области
      SerialOffs: DWORD; // Смещение серийного номера в загрузочной области
   end;

const
  MAX_PBSI = 4;
  // Описание часто используемых сигнатур
  PartialBootSectorInfo: array[1..MAX_PBSI] of TPartialBootSectorInfo = (
     ( Fs: 'FAT16'; FsOffs: $36; SerialOffs: $27 ),
     ( Fs: 'FAT32'; FsOffs: $52; SerialOffs: $43 ),
     ( Fs: 'NTFS';  FsOffs: $03; SerialOffs: $48 ),
     ( Fs: 'EXFAT'; FsOffs: $03; SerialOffs: $64 )
  );

  INVALID_SET_FILE_POINTER = DWORD( $FFFFFFFF );

/// <summary>
/// Преобразование строки с шестнадцатиричным представлением числа в целое число
/// </summary>
/// <param name="HexStr">Строка с шестнадцатиричным представлением числа</param>
/// <returns>Целое число</returns>
function HexToInt( HexStr: string ): Integer;
var
  c: Integer;
begin
   Val( '$'+HexStr, Result, c );
   if c > 0 then
      Result := -1;
end;

/// <summary>
/// Преобразование массива символов в строку
/// </summary>
/// <param name="Val">Массив символов</param>
/// <returns>Строка, полученная из входного параметра</returns>
function ConvertToString( Val: TVolumeSNBuf ): string;
var
  b: TBytes;
begin
   SetLength( b, Length( Val ) );
   Move( Val[1], b[0], Length( Val ) );
   Result := StringOf( b );
end;

/// <summary>
/// "Открытие" доступа к логическому разделу диска
/// </summary>
/// <param name="Vol">Путь к логическому диску</param>
/// <returns>True - доступ есть; False - доступа нет</returns>
function TVolumeSN.DiskOpen(Vol: PChar): Boolean;
begin
   hD := CreateFile( Vol, GENERIC_READ or GENERIC_WRITE,
                     FILE_SHARE_READ or FILE_SHARE_WRITE,
                     nil, OPEN_EXISTING, 0, 0 );
   Result := hD <> INVALID_HANDLE_VALUE;
end;

/// <summary>
/// "Закрытие" доступа к логическому разделу диска
/// </summary>
procedure TVolumeSN.DiskClose;
begin
   if hD <> INVALID_HANDLE_VALUE then
      CloseHandle( hD );
end;

/// <summary>
/// Чтение данных с диска
/// </summary>
/// <param name="Buffer">Считанные данные</param>
/// <returns>True - удалось считать; False - не удалось считать</returns>
function TVolumeSN.ReadSector(var Buffer: TVolumeSNBuf): Boolean;
var
  Read: DWORD;
begin
   Read := 0;

   // Перемещаем курсор в начало диска
   if SetFilePointer( hD, 0, nil, FILE_BEGIN ) = INVALID_SET_FILE_POINTER then
      Exit( False );

   if not ReadFile( hD, Buffer, VOLUME_SN_BUF_SIZE, Read, nil ) then
      Exit( False );

   Result := True;
end;

/// <summary>
/// Запись данных на диск
/// </summary>
/// <param name="Buffer">Записываемые данные</param>
/// <returns>True - удалось записать; False - не удалось записать</returns>
function TVolumeSN.WriteSector(var Buffer: TVolumeSNBuf): Boolean;
var
  Write: DWORD;
begin
   // Перемещаем курсор в начало диска
   if SetFilePointer( hD, 0, nil, FILE_BEGIN ) = INVALID_SET_FILE_POINTER then
      Exit( False );

   if not WriteFile( hD, Buffer, VOLUME_SN_BUF_SIZE, Write, nil ) then
      Exit( False );

   Result := True;
end;

/// <summary>
/// Получение номера логического раздела диска
/// </summary>
/// <param name="Volume">Буква раздела диска</param>
/// <returns>Номер раздела диска</returns>
function TVolumeSN.GetVolumeSN(Volume: string): string;
var
  Drive: PChar;
  Sector: TVolumeSNBuf;
  i: Integer;
  Serial: PDWORD;
  FS: string;
begin
   Drive := PChar( '\\.\' + Volume );

   // Открываем диск
   if not DiskOpen( Drive ) then
      raise Exception.Create( 'Невозможно открыть диск.' + #13 +
                               IntToStr( GetLastError ) + ': ' +
                               SysErrorMessage( GetLastError ) );

   // Читаем загрузочную область
   if not ReadSector( Sector ) then
   begin
      DiskClose;
      raise Exception.Create( 'Невозможно считать данные.' + #13 +
                               IntToStr( GetLastError ) + ': ' +
                               SysErrorMessage( GetLastError ) );
   end;

   // Поиск сигнатуры загрузочной области
   for i := 1 to MAX_PBSI do
   begin
      // Определяем нужную сигнатуру
      FS := Copy( ConvertToString( Sector ), PartialBootSectorInfo[i].FsOffs, Length( PartialBootSectorInfo[i].Fs ) );
      if PartialBootSectorInfo[i].Fs = FS then
      begin
         Serial := @Sector[PartialBootSectorInfo[i].SerialOffs];
         Result := IntToHex( DWORD( Serial^ ), 8 );
         Break;
      end;
   end;

   // Закрываем диск
   DiskClose;
end;

/// <summary>
/// Изменение номера логического раздела диска
/// </summary>
/// <param name="Volume">Буква раздела диска</param>
/// <param name="NewSN">Новый номер (DWORD)</param>
/// <returns>True - удалось изменить; False - не удалось изменить</returns>
function TVolumeSN.SetVolumeSN(Volume: string; NewSN: DWORD): Boolean;
var
  Drive: PChar;
  Sector: TVolumeSNBuf;
  i: Integer;
  FS: string;
begin
   Result := False;
   Drive := PChar( '\\.\' + Volume );

   // Открываем диск
   if not DiskOpen( Drive ) then
      raise Exception.Create( 'Невозможно открыть диск.' + #13 +
                               IntToStr( GetLastError ) + ': ' +
                               SysErrorMessage( GetLastError ) );

   // Читаем загрузочную область
   if not ReadSector( Sector ) then
   begin
      DiskClose;
      raise Exception.Create( 'Невозможно считать данные.' + #13 +
                               IntToStr( GetLastError ) + ': ' +
                               SysErrorMessage( GetLastError ) );
   end;

   // Поиск сигнатуры загрузочной области
   i := 1;
   while i <= MAX_PBSI do
   begin
      // Определяем нужную сигнатуру
      FS := Copy( ConvertToString( Sector ), PartialBootSectorInfo[i].FsOffs, Length( PartialBootSectorInfo[i].Fs ) );
      if PartialBootSectorInfo[i].Fs = FS then
         Break;
      Inc( i );
   end;

   if i > MAX_PBSI then
   begin
      DiskClose;
      raise Exception.Create( 'Невозможно сменить серийный номер тома для этой файловой системы.' );
   end;

   // Меняем номер
   PDWORD( Sector + PartialBootSectorInfo[i].SerialOffs )^ := NewSN;

   // Записываем в загрузочную область
   if not WriteSector( Sector ) then
   begin
      DiskClose;
      raise Exception.Create( 'Невозможно записать данные.' + #13 +
                               IntToStr( GetLastError ) + ': ' +
                               SysErrorMessage( GetLastError ) );
   end;

   // Закрываем диск
   DiskClose;
   Result := True;
end;

/// <summary>
/// Изменение номера логического раздела диска
/// </summary>
/// <param name="Volume">Буква раздела диска</param>
/// <param name="NewSN">Новый номер (string)</param>
/// <returns>True - удалось изменить; False - не удалось изменить</returns>
function TVolumeSN.SetVolumeSN(Volume, NewSN: string): Boolean;
var
  i: Integer;
begin
   Result := False;

   if Length( NewSN ) = 0 then
      raise Exception.Create( 'Не введен серийный номер.' );

   if Length( NewSN ) <> 8 then
      raise Exception.Create( 'Серийный номер должен состоять из 8 символов.' );

   for i := 1 to Length( NewSN ) do
      if not CharInSet( NewSN[i], ['0'..'9', 'A'..'F', 'a'..'f'] ) then
         raise Exception.Create( 'Некорректный формат серийного номера (XXXXXXXX, X = [0..9,A..F]).' );

   SetVolumeSN( Volume, HexToInt( NewSN ) );
end;

initialization
  VolumeSN := TVolumeSN.Create;

finalization
  VolumeSN.Free;

end.
