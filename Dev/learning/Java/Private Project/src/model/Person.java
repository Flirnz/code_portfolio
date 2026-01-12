package model;

import java.util.ArrayList;
import java.util.List;

/**
 * Merepresentasikan Anggota Perpustakaan (Manusia).
 * Menyimpan data diri dan daftar buku yang sedang dipinjam.
 */
public class Person implements Comparable<Person> {
    private String firstName;
    private String lastName;
    private String birthDate;
    private Address address;
    private int unpaidFees;

    // Ini "Tas Belanja" punya si orang itu.
    // Isinya buku-buku yang dia pinjam dari perpustakaan.
    private List<Book> borrowedBooks;

    public Person(String firstName, String lastName, String birthDate, Address address) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.birthDate = birthDate;
        this.address = address;
        // Pas orang dibuat, kita kasih dia tas kosong
        this.borrowedBooks = new ArrayList<>();
        this.unpaidFees = 0;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public int getUnpaidFees() {
        return unpaidFees;
    }

    public void setUnpaidFees(int fees) {
        this.unpaidFees = fees;
    }

    /**
     * Mengintip isi tas buku pinjaman orang ini.
     * 
     * @return List buku yang sedang dipinjam
     */
    public List<Book> getBorrowedBooks() {
        return borrowedBooks;
    }

    @Override
    public String toString() {
        return firstName + " " + lastName + " (" + birthDate + ") - " + address + " -Fees: Rp" + unpaidFees + " Rupiah";
    }

    @Override
    public int compareTo(Person othPerson) {
        return this.firstName.compareToIgnoreCase(othPerson.firstName);
    }
}
