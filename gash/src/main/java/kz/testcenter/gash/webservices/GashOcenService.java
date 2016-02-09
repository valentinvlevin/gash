package kz.testcenter.gash.webservices;

import kz.testcenter.gash.db.dao.ListOtvDAO;
import kz.testcenter.gash.exceptions.DAOException;
import kz.testcenter.gash.webservices.datatype.OcenRequest;
import kz.testcenter.gash.webservices.datatype.OcenResponse;
import kz.testcenter.gash.webservices.datatype.dtOcen;

import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import java.util.List;

@Stateless
@WebService(
        wsdlLocation = "/META-INF/wsdl/GashOcen.wsdl"
)
public class GashOcenService {
    @Inject
    private ListOtvDAO listOtvDAO;

    @WebMethod()
    @PermitAll
    public Boolean isAlive(){
        return true;
    }

    @WebMethod()
    @RolesAllowed("vpt")
    public OcenResponse doAnalyze(@WebParam(name = "AnswerFile") OcenRequest ocenRequest) {
        OcenResponse ocenResponse = new OcenResponse();
        try {
            List<dtOcen> ocenList = listOtvDAO.DoOcen(ocenRequest);
            ocenResponse.setResultCode(0);
            ocenResponse.setOcenList(ocenList);
        } catch (DAOException e) {
            ocenResponse.setResultCode(e.getExceptionMessage().getCode());
            ocenResponse.setErrorMessage(e.getExceptionMessage().getErrorMessage());
        } catch (Exception e) {
            e.printStackTrace();
            ocenResponse.setResultCode(1);
            ocenResponse.setErrorMessage(e.getMessage());
        }
        return ocenResponse;
    }
}
