package com.example.waiter;

import android.app.Activity;
import android.widget.Toast;

public class ServerErrors {
    public static final void ProcessErr(Activity act, int err) {
        String sErr = "";
        switch (err) {
            case -7:
                sErr = "Неправильный ответ от сервера";
                break;
            case -6:
                sErr = "Общая ошибка";
                break;
            case -5:
                sErr = "Ошибка получения данных";
                break;
            case -4:
                sErr = "Неправильный запрос на сервер";
                break;
            case -3:
                sErr = "Таймаут получения данных";
                break;
            case -2:
                sErr = "Невозможно передать данные";
                break;
            case -1:
                sErr = "Невозможно соединиться с сервером";
                break;
            default:
                sErr = "Неизвестная ошибка";
                break;
        }
        Toast.makeText(act, sErr, Toast.LENGTH_LONG).show();
    }
}
