from win32printing import Printer
import win32print

def print_termo(data):
    printer_name = win32print.GetDefaultPrinter()
    # printers = win32print.EnumPrinters(2)
    printers = win32print.EnumPrinters(6)

    printer_list = []
    for x in range(len(printers)):
        printer_list.append(printers[x][2])
 
    font = {
        "height": 23,
        "faceName": 'Anka/Coder Narrow Bold',
        "bold": True,
    }
    font1 = {
        "height": 14,
        "faceName": 'Anka/Coder Narrow',
    }
    font2 = {
        "height": 14,
        "italic": True,
        "faceName": 'Anka/Coder Narrow',
    }

    prr = data.get('prr')

    with Printer(printer_name = printer_list[prr] ,linegap=-1) as printer:
        
        printer.text(f"*** {data.get('otdel_name')} ***", align="center", font_config=font)
        y = printer.cursor.y
        printer.text(f"{data.get('stol_number')}", align="left", font_config=font)
        y = printer.cursor.y
        printer.text(f"Счет №  : "+f"{data.get('schet_number')}", align="left", font_config=font1)
        printer.cursor.y -= (printer.cursor.y - y)
        printer.text(f"{data.get('order_time')}", align="right", font_config=font1)
        y = printer.cursor.y
        printer.text("Официант:", align="left", font_config=font1)
        printer.cursor.y -= (printer.cursor.y - y)
        printer.text(f"{data.get('username')}", align="right", font_config=font1)
        printer.text("-----------------------------------", align="center", font_config=font1)
        # printer.new_page()
        mahsulotlar = data.get('orders')
        for mahsulot in mahsulotlar:
            if f"{mahsulot.get('otkaz', '')}" != '':
            # printer.text(f"{mahsulot.get('otkaz', '')}", font_config=font1)
                printer.text("------ОТКАЗ!------", align="left", font_config=font1)
                y = printer.cursor.y
                printer.text(f"{mahsulot.get('name')}", font_config=font1)
                printer.cursor.y -= (printer.cursor.y - y)
                printer.text(f"{mahsulot.get('count')}", align="right", font_config=font1)
                printer.text(f"{mahsulot.get('comment', '')}", align="right", font_config=font2)
            else:
                y = printer.cursor.y
                printer.text(f"{mahsulot.get('name')}", font_config=font1)
                printer.cursor.y -= (printer.cursor.y - y)
                printer.text(f"{mahsulot.get('count')}", align="right", font_config=font1)
                printer.text(f"{mahsulot.get('comment', '')}", align="right", font_config=font2)

        printer.text("-----------------------------------", align="center", font_config=font1)

# Sinov uchun ma'lumotlar
# if __name__ == '__main__':
#     test_data = {
#         "otdel_name": "Чой-нон",
#         "stol_number": "С собой",
#         "schet_number": 27,
#         "order_time": "28.02.2025 20:26:03",
#         "username": "КАССИР",
#         "orders": [
#             {"name": "Нон яримта", "count": 1},
#             {"name": "Нон", "count": 1},
#             {"name": "Нон катта", "count": 2},
#             {"name": "Кора чой", "count": 1},
#             {"name": "Кук чой", "count": 1},
#         ],
#         "prr": 6
#     }
#     print_termo(test_data)


# printer.text("--------------------------------------------------", align="center", font_config=font1)