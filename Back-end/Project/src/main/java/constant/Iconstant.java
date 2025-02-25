/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package constant;

import Model.GoogleAccount;
import com.google.gson.Gson;
import java.io.IOException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;

/**
 *
 * @author Admin
 */
public class Iconstant {

    public static final String GOOGLE_CLIENT_ID = "1042966270361-g65nrjskukgb6r5n2b6tbjrkbi9qi9fp.apps.googleusercontent.com";

    public static final String GOOGLE_CLIENT_SECRET = "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";

    public static final String GOOGLE_REDIRECT_URI = "http://localhost:8080/PawShop/google-login";

    public static final String GOOGLE_GRANT_TYPE = "authorization_code";

    public static final String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";

    public static final String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";

}
