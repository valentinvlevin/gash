package kz.testcenter.gash.db.entities.test;

import java.io.Serializable;

/**
 * Created by user on 14.09.2015.
 */
public class enTestId implements Serializable {

    public int getIdFile() {
        return idFile;
    }
    public void setIdFile(int idFile) {
        this.idFile = idFile;
    }
    private int idFile;

    public int getIdTest() {
        return this.idTest;
    }
    public void setIdTest(int idTest) {
        this.idTest = idTest;
    }
    private int idTest;

    @Override
    public boolean equals(Object o) {
        if (o == this) return true;
        if (o == null || o.getClass() != getClass()) return false;

        enTestId obj = (enTestId) o;
        if (obj.getIdFile() == getIdFile() && obj.getIdTest() == getIdTest())
            return true;
        else
            return false;
    }

    @Override
    public int hashCode() {
        int result = idFile;
        result = 31 * result + idTest;
        return result;
    }
}
