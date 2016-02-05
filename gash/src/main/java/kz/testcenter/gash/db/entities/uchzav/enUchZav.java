package kz.testcenter.gash.db.entities.uchzav;

import javax.persistence.*;

/**
 * Created by user on 14.09.2015.
 */
@Entity
@Table(name = "uchzav", schema = "public")
@IdClass(value = enUchZavId.class)
public class enUchZav {
    @Id
    @Column(name="id_file")
    public int getIdFile() {
        return this.idFile;
    }
    public void setIdFile(int idFile) {
        this.idFile = idFile;
    }
    private int idFile;

    @Id
    @Column(name="gid_uchzav")
    public int getGidUchZav() {
        return this.gidUchZav;
    }
    public void setGidUchZav(int gidUchZav) {
        this.gidUchZav = gidUchZav;
    }
    private int gidUchZav;

    @Column(name="uchzav_kaz")
    public String getUchZavKaz() {
        return this.uchZavKaz;
    }
    public void setUchZavKaz(String uchZavKaz) {
        this.uchZavKaz = uchZavKaz;
    }
    private String uchZavKaz;

    @Column(name="uchzav_rus")
    public String getUchZavRus() {
        return this.uchZavRus;
    }
    public void setUchZavRus(String uchZavRus) {
        this.uchZavRus = uchZavRus;
    }
    private String uchZavRus;

    public enUchZav(){

    }
}
