import ctypes
from getmac import get_mac_address
import winreg

def activate_app():


    def get_hdd_serial(drive):
        serial_number = ctypes.c_ulonglong(0)
        ctypes.windll.kernel32.GetVolumeInformationW(
            ctypes.c_wchar_p(f"{drive}:\\"),
            None, 0,
            ctypes.pointer(serial_number),
            None, None, None, 0
        )
        return str.upper(hex(serial_number.value)[2:])


    def get_mac_address_safe(interface):
        return str.upper((get_mac_address(interface=interface) or "00-00-00-00-00-00").replace(":", "-", 5))


    def get_cpu_info():
        key_path = r'HARDWARE\DESCRIPTION\System\CentralProcessor\0'
        with winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, key_path) as key:
            return ''.join(
                winreg.QueryValueEx(key, name)[0] for name in ['VendorIdentifier', 'Identifier', 'ProcessorNameString'])


    hex_serial_number = get_hdd_serial("D")
    LAN = get_mac_address_safe("LAN")
    WIFI = get_mac_address_safe("WI-FI")
    result = get_cpu_info()

    spass = hex_serial_number + LAN + WIFI + result
    skey = '720F0750' + '98-28-A6-4A-53-6D' + '3C-91-80-B6-C3-BB' + 'GenuineIntelIntel64 Family 6 Model 142 Stepping 10Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz'

    if spass != skey:
        ctypes.windll.user32.MessageBoxW(0, "Вы не можете пользоваться программой!" '\n'
                                            "Свяжитесь с системным    администратором !" '\n'
                                            "Хуршидбек :  +99893 915 51 01",
                                            "Предупреждение", 16)
        exit()

    # print('spass' + spass)
    # print('skey' + skey)

# if __name__ == '__main__':
#     activate_app()