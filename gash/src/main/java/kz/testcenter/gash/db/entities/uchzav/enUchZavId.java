package kz.testcenter.gash.db.entities.uchzav;

import java.io.Serializable;

/**
 * Created by user on 14.09.2015.
 */
public class enUchZavId implements Serializable {
    public int getIdFile() {
        return idFile;
    }
    public void setIdFile(int idFile) {
        this.idFile = idFile;
    }
    private int idFile;

    public int getGidUchZav() {
        return gidUchZav;
    }
    public void setGidUchZav(int gidUchZav) {
        this.gidUchZav = gidUchZav;
    }
    private int gidUchZav;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        enUchZavId uchZavId = (enUchZavId) o;

        if (idFile != uchZavId.idFile) return false;
        return gidUchZav == uchZavId.gidUchZav;

    }

    @Override
    public int hashCode() {
        int result = idFile;
        result = 31 * result + gidUchZav;
        return result;
    }

    public enUchZavId() {

    }
}
