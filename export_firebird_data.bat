@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

REM Firebird o'rnatilgan joy
SET FIREBIRD_PATH="C:\Progra~1\Firebird\Firebird_2_5\bin"

REM Ma'lumotlar bazasi fayli
SET DATABASE_PATH="D:\INSTALL\OJ\Others\Tog shabbodasi+\base\BASE.fdb"

REM Foydalanuvchi va parol
SET USER=SYSDBA
SET PASSWORD=masterkey

REM Natijalar uchun kataloglar
SET OUTPUT_SQL="D:\INSTALL\OJ\Others\Tog shabbodasi+\base\database_structure.sql"
SET OUTPUT_EXCEL_DIR="D:\INSTALL\OJ\Others\Tog shabbodasi+\base\Excel_EXPORT"

REM Excel katalogni yaratish (agar mavjud bo'lmasa)
mkdir %OUTPUT_EXCEL_DIR%

REM DDL eksport qilish
echo "Ma'lumotlar bazasi strukturasi SQL faylga eksport qilinmoqda..."
%FIREBIRD_PATH%\isql -u %USER% -p %PASSWORD% %DATABASE_PATH% -x > %OUTPUT_SQL%
echo "Struktura eksport tugallandi: %OUTPUT_SQL%"

REM Jadvallar ro'yxatini olish
echo "Jadvallar ro'yxati olinmoqda..."
echo SHOW TABLES; > temp_show_tables.sql
%FIREBIRD_PATH%\isql -u %USER% -p %PASSWORD% %DATABASE_PATH% -i temp_show_tables.sql -o temp_tables_raw.txt

REM Har bir jadval ma'lumotlarini Excel formatida eksport qilish
for /F "tokens=*" %%i in ('type temp_tables_raw.txt ^| findstr /R "^[A-Z]"') do (
    SET TABLE_NAME=%%i
    echo Exporting data for table: !TABLE_NAME!
    echo SET LIST ON; > temp_export.sql
    echo SPOOL %OUTPUT_EXCEL_DIR%\!TABLE_NAME!.csv; >> temp_export.sql
    echo SELECT * FROM "!TABLE_NAME!"; >> temp_export.sql
    echo SPOOL OFF; >> temp_export.sql
    %FIREBIRD_PATH%\isql -u %USER% -p %PASSWORD% %DATABASE_PATH% -i temp_export.sql
    if errorlevel 1 echo Xatolik yuz berdi: !TABLE_NAME! >> errors.log
)

REM CSV fayllarni Excel formatiga o'zgartirish
echo "CSV fayllar Excelga aylantirilmoqda..."
for %%f in (%OUTPUT_EXCEL_DIR%\*.csv) do (
    ren "%%f" "%%~nf.xlsx"
)

REM Tozalash
del temp_show_tables.sql
del temp_export.sql
del temp_tables_raw.txt

echo "Barcha jarayonlar tugadi!"
pause
