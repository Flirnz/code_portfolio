package model;

/**
 * Mempresentasikan alamat fisik dari seseorang.
 * Class ini menyimpan nama jalan, nomor rumah, kode pos, dan kota.
 * 
 * @author Ferdinand
 */
public class Address {
    private String street;
    private String houseNumber;
    private String zipCode;
    private String city;

    /**
     * Membuat object Address baru dengan data lengkap.
     * 
     * @param street      Nama jalan (contoh: Jl. Merdeka)
     * @param houseNumber Nomor rumah
     * @param zipCode     Kode pos
     * @param city        Nama kota
     */
    public Address(String street, String houseNumber, String zipCode, String city) {
        this.street = street;
        this.houseNumber = houseNumber;
        this.zipCode = zipCode;
        this.city = city;
    }

    /**
     * Mengambil nama jalan.
     * @return Nama jalan
     */
    public String getStreet() {
        return street;
    }

    /**
     * Mengubah nama jalan.
     * @param street Nama jalan baru
     */
    public void setStreet(String street) {
        this.street = street;
    }

    /**
     * Mengambil nomor rumah.
     * @return Nomor rumah
     */
    public String getHouseNumber() {
        return houseNumber;
    }

    /**
     * Mengubah nomor rumah.
     * @param houseNumber Nomor rumah baru
     */
    public void setHouseNumber(String houseNumber) {
        this.houseNumber = houseNumber;
    }

    /**
     * Mengambil kode pos.
     * @return Kode pos
     */
    public String getZipCode() {
        return zipCode;
    }

    /**
     * Mengubah kode pos.
     * @param zipCode Kode pos baru
     */
    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    /**
     * Mengambil nama kota.
     * @return Nama kota
     */
    public String getCity() {
        return city;
    }

    /**
     * Mengubah nama kota.
     * @param city Nama kota baru
     */
    public void setCity(String city) {
        this.city = city;
    }

    /**
     * Mengembalikan representasi String dari alamat lengkap.
     * Format: "Jalan No, KodePos Kota"
     */
    @Override
    public String toString() {
        return street + " " + houseNumber + ", " + zipCode + " " + city;
    }
}