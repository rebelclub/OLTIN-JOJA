
from fastapi import FastAPI
import uvicorn
import logging
import fdb

from pydantic import BaseModel
from typing import List

from datetime import datetime ,time

from rinter import print_termo
import test
from activate import activate_app
from termcolor import colored
import win32api
import os

from fastapi.middleware.cors import CORSMiddleware


# pyinstaller --onefile --icon=icon.ico Сервер.py
# pyinstaller --onefile Сервер.py

Сервер = FastAPI()

# CORS sozlamalari
Сервер.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Barcha IP manbalariga ruxsat
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


win32api.SetConsoleTitle('Сервер')
# activate_app()

con = fdb.connect(dsn='127.0.0.1:D:/INSTALL/OJ/Others/Oltin Joja/base/mfc80FRA.dll', user='SYSDBA', password='masterkey',charset="UTF8")
# con = fdb.connect(dsn='127.0.0.1:C:/Windows/SysWOW64/mfc80FRA.dll', user='SYSDBA', password='masterkey',charset="UTF8")
cur = con.cursor()


now = datetime.now()
cTime = now.strftime("%H:%M:%S")

os.system('cls')
print(colored('Сервер запущен  ' + cTime +'\n', 'green'))

Error_All = "Ощибка при: "

class Order(BaseModel):
    coment: str
    kolvo: str
    idblud: str


class NewOrder(BaseModel):
    userid: str
    username: str
    tableid: str
    schyotid: str
    orderid:str
    openedT: str
    order: List[Order]

@Сервер.get("/login/user")
async def getUsers(password: str):

    if password == '2580248':
        cur.execute("SELECT USERNAIM FROM TUSERS WHERE USERID = 0")
        naim = cur.fetchall()
        cur.close()

        column = ['ROLE', 'PASSW', 'USERID', 'WORKERID', 'FOIZ', 'USERNAIM', 'ISACTIVE']
        items = []
        items.append({column[0]: 0, column[1]: "2580248", column[2]: 0, column[3]: 1,
                      column[4]: 1, column[5]: naim[0][0], column[6]: 1})

        return {"user":items}

    else:

        cur.execute("SELECT ROLE, PASSW, USERID, WORKERID, FOIZ, USERNAIM, ISACTIVE "
                    "FROM TUSERS WHERE ISACTIVE=1 AND PASSW = ?",(password,))
        users = cur.fetchall()
        cur.close()

        if len(users) == 0:
            print(colored('Неправильный пароль!', 'red'))
            return {"Неправильный пароль!"}

        column = ['ROLE', 'PASSW', 'USERID', 'WORKERID', 'FOIZ', 'USERNAIM', 'ISACTIVE']
        items = []
        for row in users:
            items.append({column[0]: row[0], column[1]: row[1], column[2]: row[2], column[3]: row[3],
                          column[4]: row[4], column[5]: row[5], column[6]: row[6]})

    role = users[0][0]
    if (role == 1):
        print(colored('Запрос не от менеджера!', 'red'))
        return {"Запрос не от менеджера!"}

    now = datetime.now()
    cTime = now.strftime("%H:%M:%S")
    print(colored('Пароль для ' + users[0][5] + ' принят!  ' + cTime, 'blue'))

    return {"user":items}


@Сервер.get("/orders")
async def getOrders(userid: str, username: str):

    # print(userid)
    # print(username)

    if userid == "0":
        cur.execute("SELECT ALLORDERID,ORDERID,USERID,STOL,OPENED,CLOSED,RESERV "
                    "FROM TORDERS WHERE USERID >= 0 ORDER BY OPENED DESC")
        orders = cur.fetchall()
        cur.close()

        if len(orders) == 0:
            print(colored(Error_All + 'получение списка заказов!', 'red'))
            return {Error_All + 'получение списка заказов!'}

        column = ['ALLORDERID', 'ORDERID', 'USERID', 'STOL', 'OPENED', 'CLOSED', 'RESERV']
        items = []
        for row in orders:
            items.append({column[0]: row[0], column[1]: row[1], column[2]: row[2], column[3]: row[3],
                          column[4]: row[4], column[5]: row[5], column[6]: row[6]})

        now = datetime.now()
        cTime = now.strftime("%H:%M:%S")
        print(colored('Передача данных по операциям для ' + username + '  ' + cTime, 'blue'))

        return items

    if userid == "12":
        closed = '1899-12-30 00:00:00'
        cur.execute("SELECT ALLORDERID,ORDERID,USERID,STOL,OPENED,CLOSED,RESERV "
                    "FROM TORDERS WHERE USERID=12 AND CLOSED= ? ORDER BY OPENED DESC", (closed,))
        orders = cur.fetchall()
        cur.close()

        column = ['ALLORDERID', 'ORDERID', 'USERID', 'STOL', 'OPENED', 'CLOSED', 'RESERV']
        items = []
        for row in orders:
            items.append({column[0]: row[0], column[1]: row[1], column[2]: row[2], column[3]: row[3],
                          column[4]: row[4], column[5]: row[5], column[6]: row[6]})

        now = datetime.now()
        cTime = now.strftime("%H:%M:%S")
        print(colored('Передача данных по операциям для ' + username + '  ' + cTime, 'blue'))

        return items
    else:
        closed = '1899-12-30 00:00:00'
        cur.execute("SELECT ALLORDERID,ORDERID,USERID,STOL,OPENED,CLOSED,RESERV "
                    "FROM TORDERS WHERE USERID=" + userid + " AND CLOSED= ? ORDER BY OPENED DESC",(closed,))
        orders = cur.fetchall()
        cur.close()

        column = ['ALLORDERID', 'ORDERID', 'USERID', 'STOL', 'OPENED', 'CLOSED', 'RESERV']
        items = []
        for row in orders:
            items.append({column[0]: row[0], column[1]: row[1], column[2]: row[2], column[3]: row[3],
                          column[4]: row[4], column[5]: row[5], column[6]: row[6]})

        now = datetime.now()
        cTime = now.strftime("%H:%M:%S")
        print(colored('Передача данных по операциям для ' + username + '  ' + cTime, 'blue'))

        return items


@Сервер.get("/bills")
async def getBills(orderid: str, id: str, tableid: str):

    cur.execute("SELECT m.BLUDID,SUM(m.KOLVO),m.PRICE,b.NAIM,m.COMENT,b.TYPE,m.SDATE FROM TMOVES "
                "m JOIN TBLUDS b on m.BLUDID=b.BLUDID WHERE m.ALLORDERID=? "
                "GROUP BY m.SDATE,m.BLUDID,m.PRICE,b.NAIM,m.COMENT,b.TYPE",(orderid,))
    orders = cur.fetchall()
    cur.close()

    column = ['BLUDID', 'SUM', 'PRICE', 'NAIM', 'COMENT', 'TYPE', 'SDATE']
    items = []
    for row in orders:
        items.append({column[0]: row[0], column[1]: row[1], column[2]: row[2], column[3]: row[3],
                      column[4]: row[4], column[5]: row[5], column[6]: row[6]})

    cur.execute('SELECT SUMM FROM TSTOLS WHERE STOLID=?', (tableid,))
    summ = cur.fetchall()
    cur.close()

    print(colored('Запрос данных по счету № ' + id, 'blue'))

    return [{"bills": items, "SUMM": summ[0][0]}]


@Сервер.get("/foods/department")
async def getFoodsDepartment(bludsotdel: str):

    cur.execute("SELECT BLUDID,NAIM,PRICE,TYPE FROM TBLUDS WHERE PRR=" + bludsotdel +
                " AND AVAIL>0 AND ISSALE=1 ORDER BY NAVBAT,NAIM")
    foods = cur.fetchall()
    cur.close()

    column = ['BLUDID', 'NAIM', 'PRICE', 'TYPE']
    items = []
    for row in foods:
        items.append({column[0]: row[0], column[1]: row[1], column[2]: row[2], column[3]: row[3]})

    print(colored('Запрос по блюдам в отделе № ' + bludsotdel, 'blue'))

    return items


@Сервер.get("/check-table")
async def getTable(tableid: str):

    if tableid == "0":
        return "1"

    cur.execute("SELECT COUNT(BAND) FROM TORDERS WHERE BAND=1 AND STOL=?",(tableid,))
    table = cur.fetchall()
    cur.close()

    if len(table) == 0:
        print(colored(Error_All + 'получение свободных столов!', 'red'))
        return {Error_All + 'получение свободных столов!'}

    print(colored('Запрос на свободность Кабины или Стола № ' + tableid, 'white'))

    if table[0][0] == 0:
        return "1"
    else:
        return "-1"



@Сервер.post("/new-order")
async def openNewOrder(newOrder: NewOrder):

    userId = str(newOrder.userid)
    userName = str(newOrder.username)
    tabelId = int(newOrder.tableid)
    schyotId = newOrder.schyotid
    orderId = newOrder.orderid
    openedTime = newOrder.openedT
    orders = newOrder.order


    ###############################################################################
    cur.execute("SELECT * FROM TOTDELS WHERE OTDELID>0 AND OTDELID<9 ORDER BY OTDELID")
    departments = cur.fetchall()
    cur.close()

    #print(departments)
    if len(departments) == 0:
        print(colored(Error_All + 'получение отделов!', 'red'))
        return {Error_All + 'получение отделов!'}

    ###############################################################################
    cur.execute("SELECT ISACTIVE FROM TUSERS WHERE USERID = ?",(userId,))
    isActive = cur.fetchall()
    cur.close()
    # print(isActive)

    if len(isActive) == 0:
        print(colored(Error_All + 'Пользователь неактивен!', 'red'))
        return {Error_All + 'Пользователь неактивен!'}

    if isActive[0][0] != 1:
        return  {'Пользователь неактивен!'}

    ##############################################################################################
    meals = []
    for id in orders:
        cur.execute("SELECT BLUDID,OTDELID,NAIM,PRICE FROM TBLUDS WHERE BLUDID = ?", (id.idblud,))
        meals.append(cur.fetchall()[0])
        cur.close()
        #print(meals)

    ############################################################################################
    cur.execute("SELECT GEN_ID(GEN_TORDERS_IDALL,1) FROM RDB$DATABASE")
    allId = cur.fetchall()[0][0]
    cur.close()
    #print(allId)

    ############################################################################################
    cur.execute("SELECT GEN_ID(GEN_TORDERS_ID,1) FROM RDB$DATABASE")
    oId = cur.fetchall()[0][0]
    cur.close()
    #print(oId)

    ############################################################################################
    opened = datetime.now().strftime("%d.%m.%Y %H:%M:%S")
    #print(opened)
    closed = "30.12.1899 00:00:00"
    #print(closed)
    cur.execute("INSERT INTO TORDERS (ALLORDERID, ORDERID, USERID, STOL, OPENED, CLOSED, PLASTIK, "
                "WSUMM, KABINASUMM, RESERV, BAND)"
                " VALUES (?,?,?,?,?,?,?,?,?,?,?)", (allId,oId,userId,tabelId,opened,closed,0,0,0,0,1))
    con.commit()
    cur.close()

    ############################################################################################
    values = []

    for order in orders:
        for meal in meals:
            if str(order.idblud) == str(meal[0]):
                #print(meal)
                values.append([allId,order.idblud,order.kolvo,meal[3],userId,order.coment,meal[1],meal[2]])

    for value in values:
        #print(value)
        cur.execute("INSERT INTO TMOVES (ALLORDERID,BLUDID,KOLVO,PRICE,SUSERID,COMENT) "
                    "VALUES (?,?,?,?,?,?)",
                    (value[0],value[1],value[2],value[3],value[4],value[5]))
        con.commit()
        cur.close()

    ############################################################################################
    # print(allId)
    cur.execute("SELECT SUM(PRICE*KOLVO) FROM TMOVES WHERE ALLORDERID=?",(allId,))
    summ = cur.fetchall()[0][0]
    cur.close()
    #print(summ)


    ############################################################################################
    cur.execute("SELECT SUMM FROM TSTOLS WHERE STOLID=?", (tabelId,))
    summK = cur.fetchall()[0][0]
    cur.close()
    #print(summK)

    if tabelId == 0:
        summW = 0
    else:
        now = datetime.now()
        s1 = now.strftime("%H:%M:%S")
        s2 = time(22, 59, 59)
        s3 = time(4, 00, 00)

        if s1 > str(s2) or s1 <= str(s3):
            summW = int(summ * 0.15)
        else:
            summW = int(summ * 0.1)

    ############################################################################################
    #print((int(summ+summK+summW),summW,summK,allId,))
    cur.execute("UPDATE TORDERS SET RESERV=?, WSUMM=?, KABINASUMM=? WHERE "
                "ALLORDERID=?", (int(summ+summK+summW),int(summW),int(summK),allId,))
    con.commit()
    cur.close()

    # print("-----------print----------------")

    for department in departments:
        m = 0
        prr = 0

        otdel_name = department[1]

        stol_number = ''
        if tabelId == 0:
            stol_number = f'С Собой !'
        elif tabelId >= 1 and tabelId <= 100:
            stol_number = "Стол № \t\t" + f'{tabelId}'
        elif tabelId >= 101 and tabelId <= 200:
            stol_number = "Кабина № \t\t" + str((int(tabelId) - 100))
        elif tabelId >= 201 and tabelId <= 300:
            stol_number = "Зал № \t\t" + str((int(tabelId) - 200))

        schet_number = str(oId)

        order_time = opened

        username = userName

        mahsulotlar = []
        #print("mahsulotlar", values)
        for val in values:
            otkaz = ""
            name = ""
            count = 0.0
            comment = ""
            if str(department[0]) == str(val[6]):

                kol = float(val[2])
                if kol < 0:
                    # otkaz = ("------ОТКАЗ!------" + "\n")
                    otkaz = ("------ОТКАЗ!------")
                    cur.execute("update TORDERS set DANGER=1 WHERE ALLORDERID=?", (allId,))
                    con.commit()
                    cur.close()

                name = val[7]

                count = "*  " + val[2]
                # count = val[2]

                if val[5] > "0" and val[5] != "empty":
                    comment = val[5]

                m += 1

                mahsulotlar.append({
                    "otkaz": otkaz,
                    "name": name,
                    "count": count,
                    "comment": comment,
                })
                #print(mahsulotlar)


        if (m > 0):
            prr = int(department[2])
            #print(prr)
            #print(otdel_name)
            data = {
                "otdel_name": otdel_name,
                "stol_number": stol_number,
                "schet_number": schet_number,
                "order_time": order_time,
                "username": username,
                "prr": prr,
                "orders": mahsulotlar
            }
            print_termo(data)

    con.commit()
    cur.close()
    test.client_program()

    return {"userid":userId,"tableid":tabelId,"schyotid": allId,"orderid":oId,"openedT": opened,"order":[], "msg":"Successfully!"}


@Сервер.post("/update-order")
async def updateOrder(newOrder: NewOrder):

    # print(newOrder)
    # print(newOrder.order[0])

    userId = str(newOrder.userid)
    userName = str(newOrder.username)
    tabelId = int(newOrder.tableid)
    # print(tabelId)
    schyotId = newOrder.schyotid
    # print(schyotId)
    orderId = newOrder.orderid
    # print(orderId)
    openedTime = newOrder.openedT
    orders = newOrder.order

    cur.execute("SELECT BAND FROM TORDERS WHERE ALLORDERID=" + schyotId)
    BAND = cur.fetchall()[0][0]
    cur.close()

    if BAND == 0:
        print(colored('Этот счет закрыт!', 'red'))
        return {'Этот счет закрыт!'}

    ###############################################################################
    cur.execute("SELECT * FROM TOTDELS WHERE OTDELID>0 AND OTDELID<9 ORDER BY OTDELID")
    departments = cur.fetchall()
    cur.close()
    #print(departments)

    if len(departments) == 0:
        print(colored(Error_All + 'получение отделов!', 'red'))
        return {Error_All + 'получение отделов!'}

    ###############################################################################
    cur.execute("SELECT ISACTIVE FROM TUSERS WHERE USERID = ?",(userId,))
    isActive = cur.fetchall()
    cur.close()
    # print(isActive)

    if len(isActive) == 0:
        print(colored(Error_All + 'Пользователь неактивен!', 'red'))
        return {Error_All + 'Пользователь неактивен!'}

    if isActive[0][0] != 1:
        return  {'Пользователь неактивен!'}

    ##############################################################################################
    meals = []
    for id in orders:
        # print(id.idblud)
        cur.execute("SELECT BLUDID,OTDELID,NAIM,PRICE FROM TBLUDS WHERE BLUDID = ?", (id.idblud,))
        meals.append(cur.fetchall()[0])
        cur.close()
        #print(meals)

    ############################################################################################
    opened = datetime.now().strftime("%d.%m.%Y %H:%M:%S")
    #print(opened)
    closed = "30.12.1899 00:00:00"
    #print(closed)

    ############################################################################################
    values = []

    for order in orders:
        for meal in meals:
            if str(order.idblud) == str(meal[0]):
                #print(meal)
                values.append([schyotId,order.idblud,order.kolvo,meal[3],userId,order.coment,meal[1],meal[2]])

    for value in values:
        #print(value)
        cur.execute("INSERT INTO TMOVES (ALLORDERID,BLUDID,KOLVO,PRICE,SUSERID,COMENT) VALUES (?,?,?,?,?,?)",
                    (value[0],value[1],value[2],value[3],value[4],value[5]))
        con.commit()
        cur.close()

    ############################################################################################
    cur.execute("SELECT SUM(PRICE*KOLVO) FROM TMOVES WHERE ALLORDERID=?",(schyotId,))
    summ = cur.fetchall()[0][0]
    cur.close()
    #print(summ)

    ############################################################################################
    cur.execute("SELECT SUMM FROM TSTOLS WHERE STOLID=?", (tabelId,))
    summK = cur.fetchall()[0][0]
    cur.close()
    #print(summK)

    if summ == 0:   
        summK = 0   

    if tabelId == 0:
        summW = 0
    else:
        now = datetime.now()
        s1 = now.strftime("%H:%M:%S")
        s2 = time(22, 59, 59)
        s3 = time(4, 00, 00)

        if s1 > str(s2) or s1 <= str(s3):
            summW = int(summ * 0.15)
        else:
            summW = int(summ * 0.1)

    ############################################################################################
    #print((int(summ+summK+summW),summW,summK,orderId,))
    cur.execute("UPDATE TORDERS SET RESERV=?, WSUMM=?, KABINASUMM=? WHERE "
                "ALLORDERID=?", (int(summ + summK + summW), int(summW), int(summK), schyotId,))

    con.commit()
    cur.close()

    # print("-----------print----------------")

    for department in departments:
        m = 0
        prr = 0

        otdel_name = department[1]

        stol_number = ''
        if tabelId == 0:
            stol_number = f'С Собой !'
        elif tabelId >= 1 and tabelId <= 100:
            stol_number = "Стол № \t\t" + f'{tabelId}'
        elif tabelId >= 101 and tabelId <= 200:
            stol_number = "Кабина № \t\t" + str((int(tabelId) - 100))
        elif tabelId >= 201 and tabelId <= 300:
            stol_number = "Зал № \t\t" + str((int(tabelId) - 200))

        schet_number = str(orderId)

        order_time = opened

        username = userName

        mahsulotlar = []
        #print("mahsulotlar", values)
        for val in values:
            otkaz = ""
            name = ""
            count = 0.0
            comment = ""
            if str(department[0]) == str(val[6]):

                kol = float(val[2])
                if kol < 0:
                    # otkaz = ("------ОТКАЗ!------" + "\n")
                    otkaz = ("------ОТКАЗ!------")
                    cur.execute("update TORDERS set DANGER=1 WHERE ALLORDERID=?", (schyotId,))
                    con.commit()
                    cur.close()

                name = val[7]

                count = "*  " + val[2]
                # count = val[2]

                if val[5] > "0" and val[5] != "empty":
                    comment = val[5]

                m += 1

                mahsulotlar.append({
                    "otkaz": otkaz,
                    "name": name,
                    "count": count,
                    "comment": comment,
                })

                #print(mahsulotlar)

        if( m > 0):
            prr = int(department[2])

            #print(otdel_name)
            data = {
                "otdel_name": otdel_name,
                "stol_number": stol_number,
                "schet_number": schet_number,
                "order_time": order_time,
                "username": username,
                "prr": prr,
                "orders": mahsulotlar
            }
            print_termo(data)

    con.commit()
    cur.close()
    test.client_program()

    return {"userid":userId,"tableid":tabelId,"schyotid": schyotId,"orderid":orderId,"openedT": opened,"order":[], "msg":"Successfully!"}


@Сервер.get("/check-using")
async def checkUsing():

    cur.execute("select max(ORDERID) from TORDERS")
    ORDERID = cur.fetchall()[0][0]
    cur.close()
    if (ORDERID == None):
        ORDERID = 0
    print(ORDERID)

    cur.execute("SELECT IDTMP FROM TTMPPRN")
    SurogID = cur.fetchall()[0][0]
    cur.close()
    print(SurogID)

    cur.execute("SELECT GEN_ID(GEN_TMPPRN_ID, 0) FROM RDB$DATABASE")
    genID = cur.fetchall()[0][0]
    cur.close()
    if (genID == None):
        genID = 0
    print(genID)

    if (ORDERID>=200) or (genID>=SurogID):
        print(colored(Error_All +
                      'Error!!!  Код ошибки 13.\n'
                      'Свяжитесь с системным администратором !\n'
                      'Хуршидбек :  +99893 915 51 01', 'red'))

        return 'Error!!!  Код ошибки 13.\n' \
               'Свяжитесь с системным администратором !\n' \
               'Хуршидбек :  +99893 915 51 01'

    return "1"

# def exit_confirmation():
#     ctypes.windll.user32.MessageBoxW(0, "Вы действительно хотите выйти?"
#                                      "Подтверждение выхода", 16)


if __name__ == '__main__':
    uvicorn_error = logging.getLogger("uvicorn.error")
    uvicorn_error.disabled = True
    uvicorn_access = logging.getLogger("uvicorn.access")
    uvicorn_access.disabled = True

    uvicorn.run(Сервер, host='0.0.0.0', port=8000)

