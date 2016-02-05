package kz.testcenter.gash.db.entities.kpo;

import javax.persistence.*;

/**
 * Created by user on 18.09.2015.
 */
@Entity
@Table(name = "kpo", schema = "public")
@IdClass(enKPOId.class)
public class enKPO {
    @Id
    @Column(name = "id_season")
    public short getIdSeason() {
        return idSeason;
    }
    public void setIdSeason(short idSeason) {
        this.idSeason = idSeason;
    }
    private short idSeason;

    @Id
    @Column(name = "class_no")
    public short getClassNo() {
        return classNo;
    }
    public void setClassNo(short classNo) {
        this.classNo = classNo;
    }
    private short classNo;

    @Id
    @Column(name = "variant")
    public short getVariant() {
        return variant;
    }
    public void setVariant(short variant) {
        this.variant = variant;
    }
    private short variant;

    @Id
    @Column(name = "ord")
    public short getOrd() {
        return ord;
    }
    public void setOrd(short ord) {
        this.ord = ord;
    }
    private short ord;

    @Column(name = "id_predmet")
    public short getIdPredmet() {
        return idPredmet;
    }
    public void setIdPredmet(short idPredmet) {
        this.idPredmet = idPredmet;
    }
    private short idPredmet;

    @Column(name = "kods")
    public String getKods() {
        return kods;
    }
    public void setKods(String kods) {
        this.kods = kods;
    }
    private String kods;

    @Column(name = "lang")
    public short getLang() {
        return lang;
    }
    public void setLang(short lang) {
        this.lang = lang;
    }
    private short lang;
}
