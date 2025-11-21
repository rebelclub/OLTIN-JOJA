package com.example.waiter;

import android.os.AsyncTask;
import android.util.Log;
import java.io.DataInputStream;
import java.io.IOException;
import java.net.Socket;
import java.util.concurrent.TimeUnit;

public class ServerConnection extends AsyncTask<String, Void, Void> {
    public static final String LOG_TAG = "myApp";
    private String mServerName;
    private int mServerPort;
    private Socket mSocket;
    public String recv;
    public int status;

    public ServerConnection() {
        this.mServerName = "192.168.1.99";
//        this.mServerName = "192.168.11.236";
        this.mServerPort = 6766;
        this.mSocket = null;
        this.recv = "";
        this.status = 0;

    }

    protected Void doInBackground(String... params) {
        IOException e;
        StringBuilder stringBuilder;
        InterruptedException e2,e3;

        String reqw = params[0];
        try {
            this.mSocket = new Socket(this.mServerName, this.mServerPort);

            Log.e(LOG_TAG, "Сокет создан");
            if (!(this.mSocket == null || this.mSocket.isClosed())) {
                try {
                    this.mSocket.getOutputStream().write(reqw.getBytes());
                    this.mSocket.getOutputStream().flush();
                    Log.e(LOG_TAG, "Данные отправлены:[" + reqw + "]");
                } catch (IOException ex) {
                    Log.e(LOG_TAG, "Невозможно отправить данные: " + ex.getMessage());
                    this.status = -2;
                    return null;
                }
            }
            StringBuilder ln = new StringBuilder(5);
            if (this.mSocket == null || this.mSocket.isClosed()) {
                return null;
            }

            try {
                DataInputStream iStream = new DataInputStream(this.mSocket.getInputStream());
                int pauseCnt = 0;
                while (iStream.available() == 0) {
                    TimeUnit.MILLISECONDS.sleep(200);
                    pauseCnt++;
                    if (pauseCnt > 50) {
                        Log.e(LOG_TAG, "Отсутствуют данные в сокете");
                        this.status = -3;
                        return null;
                    }
                }
                TimeUnit.MILLISECONDS.sleep(300);
                while (iStream.available() > 0) {
                    byte dt = iStream.readByte();
                    if (((char) dt) == '#') {
                        break;
                    }
                    ln.append((char) dt);
                }
                int len = Integer.parseInt(ln.toString());
                if (len == 0) {
                    Log.e(LOG_TAG, "Неправильный запрос");
                    this.status = -4;
                    return null;
                }
                Log.e(LOG_TAG, "Data ln: " + len);
                StringBuilder ret = new StringBuilder(len);
                int i = 0;
                while (i < len) {
                    try {
                        int b = iStream.readByte();
                        if (b > 0) {
                            ret.append((char) b);
                        } else {
                            ret.append((char) (b + 1104));
                        }
                        i++;
                    } catch (IOException e4) {
                        e4.printStackTrace();
                        stringBuilder = ret;
                    }
                }
                this.recv = ret.toString();
                this.status = 1;
                return null;
            } catch (IOException ex) {
                Log.e(LOG_TAG, "Невозможно получить данные: " + ex.getMessage());
                this.status = -5;
                return null;
            } catch (InterruptedException e7) {
                e2 = e7;
                e2.printStackTrace();
                this.status = -6;
                return null;
            }
        } catch (IOException e32) {
            Log.e(LOG_TAG, "Невозможно создать сокет2: " + e32.getMessage());
            this.status = -1;
            return null;
        }
    }

    public void closeConnection() {
        if (!(this.mSocket == null || this.mSocket.isClosed())) {
            try {
                this.mSocket.close();
            } catch (IOException e) {
                Log.e(LOG_TAG, "Невозможно закрыть сокет: " + e.getMessage());
            } finally {
                this.mSocket = null;
            }
        }
        this.mSocket = null;
    }

    protected void finalize() throws Throwable {
        super.finalize();
        closeConnection();
    }
}
