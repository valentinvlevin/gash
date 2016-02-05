package kz.testcenter.gash.webservices.datatype;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;
import java.util.List;

/**
 * Created by user on 18.09.2015.
 */
@XmlAccessorType(XmlAccessType.PROPERTY)
@XmlType(name = "OcenResponse")
public class OcenResponse {
    @XmlElement(name = "result_code", required = true)
    public int getResultCode() {
        return resultCode;
    }
    public void setResultCode(int resultCode) {
        this.resultCode = resultCode;
    }
    private int resultCode;

    @XmlElement(name = "error_message", required = false)
    public String getErrorMessage() {
        return errorMessage;
    }
    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }
    private String errorMessage;

    @XmlElement(name = "ocen_list", required = false)
    public List<dtOcen> getOcenList() {
        return ocenList;
    }
    public void setOcenList(List<dtOcen> ocenList) {
        this.ocenList = ocenList;
    }
    private List<dtOcen> ocenList;
}
