package kz.testcenter.gash.webservices;

import java.io.IOException;
import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.UnsupportedCallbackException;
import org.apache.ws.security.WSPasswordCallback;

public class ServerPasswordCallback implements CallbackHandler {

    public void handle(Callback[] callbacks) throws IOException, UnsupportedCallbackException {

        for (int i = 0; i < callbacks.length; i++) {
            WSPasswordCallback pwcb = (WSPasswordCallback)callbacks[i];
            if (pwcb.getUsage() == WSPasswordCallback.USERNAME_TOKEN) {
                if(pwcb.getIdentifier().equals("User") && pwcb.getPassword().equals("1234")) {
                    return;
                } else {
                    throw new UnsupportedCallbackException(callbacks[i], "check failed");
                }
            }
        }
    }
}