package service;

import java.util.ArrayList;
import java.util.List;
import model.*;
import java.util.stream.Collectors;

/**
 * LibraryService adalah "Otak" atau "Manager" dari perpustakaan ini.
 * Class ini bertugas untuk:
 * 1. Menyimpan data semua Buku (Rak Buku).
 * 2. Menyimpan data semua Member (Daftar Anggota).
 * 3. Mengurus transaksi seperti Pinjam Buku, Tambah Buku, dll.
 */
public class LibraryService {
    // List<Book> ibarat "Rak Fisik" di perpus.
    private List<Book> books;

    // List<Person> ibarat "Buku Tamu" / Database member
    private List<Person> persons;

    /**
     * Constructor: Dijalankan saat Perpustakaan pertama kali dibuka (dibuat).
     * Disini kita siapin list kosong biar gak error (NullPointerException).
     */
    public LibraryService() {
        this.books = new ArrayList<>();
        this.persons = new ArrayList<>();
    }

    // ==========================================
    // BAGIAN 1: MANAJEMEN BUKU (CRUD Book)
    // ==========================================

    /**
     * Menambahkan buku baru ke dalam rak perpustakaan.
     * 
     * @param newBook Object buku yang mau dimasukin
     */
    public void addBook(Book newBook) {
        books.add(newBook);
        System.out.println("[INFO] Book added successfully: " + newBook.getTitle());
    }

    /**
     * Mengambil daftar semua buku yang ada di rak saat ini.
     * 
     * @return List semua buku
     */
    public List<Book> getBooks() {
        return books;
    }

    /**
     * Membuang buku dari rak (misal karena hilang atau dibakar).
     * 
     * @param book Object buku yang mau dibuang
     */
    public void removeBook(Book book) {
        if (books.contains(book)) {
            books.remove(book);
            System.out.println("[INFO] Book removed successfully: " + book.getTitle());
        } else {
            System.out.println("[WARN] Book not found in library!");
        }
    }

    /**
     * Mencari buku berdasarkan Judulnya.
     * 
     * @param title Judul yang dicari (tidak peduli huruf besar/kecil)
     * @return Object Book kalo ketemu, atau null kalo gak ada
     */
    public Book findBookByTitle(String title) {
        for (Book buku : books) {
            if (buku.getTitle().equalsIgnoreCase(title)) {
                return buku; // Langsung balikin bukunya dan berhenti nyari
            }
        }
        return null; // Udah dicari sampe abis tetep gak ketemu
    }

    // ==========================================
    // BAGIAN 2: MANAJEMEN ANGGOTA (CRUD Person)
    // ==========================================

    /**
     * Mendaftarkan orang baru jadi member perpustakaan.
     * 
     * @param person Object orang yang mau daftar
     */
    public void registerPerson(Person person) {
        persons.add(person);
        System.out.println("[INFO] New member registered: " + person.getFirstName());
    }

    /**
     * Mencari member berdasarkan Nama Depan.
     * 
     * @param name Nama depan yang dicari
     * @return Object Person kalo ketemu, atau null
     */
    public Person findPersonByName(String name) {
        for (Person p : persons) {
            if (p.getFirstName().equalsIgnoreCase(name)) {
                return p;
            }
        }
        return null;
    }

    /**
     * Mengambil daftar semua member yang terdaftar.
     * 
     * @return List semua member
     */
    public List<Person> getPersons() {
        return persons;
    }

    // ==========================================
    // BAGIAN 3: TRANSAKSI (Pinjam Meminjam)
    // ==========================================

    /**
     * Memproses peminjaman buku.
     * Memindahkan buku dari Rak Perpustakaan ke Kantong Member.
     * 
     * @param person Siapa yang mau minjem?
     * @param book   Buku apa yang mau dipinjem?
     */
    public void borrowBooks(Person person, Book book) {
        // Cek dulu, bukunya ada di rak gak?
        if (books.contains(book)) {
            // 1. Ambil fisik buku dari rak (Remove dari Library)
            books.remove(book);

            // 2. Masukin ke kantong si peminjam (Add ke Person)
            person.getBorrowedBooks().add(book);

            System.out.println("[SUCCESS] " + person.getFirstName() + " successfully borrowed: " + book.getTitle());
        } else {
            System.out.println(
                    "[FAILED] Sorry " + person.getFirstName() + ", book '" + book.getTitle()
                            + "' is currently unavailable.");
        }
    }

    /**
     * Memproses pengembalian buku dari member ke perpustakaan.
     * Method ini juga menghitung denda jika ada keterlambatan atau kerusakan.
     * 
     * @param person       Siapa yang mengembalikan buku?
     * @param book         Buku mana yang dikembalikan?
     * @param weeksOverdue Berapa minggu terlambat? (0 jika tepat waktu)
     * @param newCondition Kondisi buku saat dikembalikan (NEW, GOOD, DAMAGED, LOST)
     */
    public void returnBook(Person person, Book book, int weeksOverdue, model.BookCondition newCondition) {
        // Cek dulu, bener gak orang ini minjem buku tersebut?
        if (person.getBorrowedBooks().contains(book)) {
            // 1. Ambil dari tas user
            person.getBorrowedBooks().remove(book);

            // 2. Balikin ke rak perpus
            books.add(book);

            // 3. Update kondisi buku sesuai keadaan fisik pas balik
            book.setCondition(newCondition);

            // --- HITUNG DENDA ---
            int dendaTelat = weeksOverdue * 5000; // Misal: Rp 5.000 per minggu telat
            int dendaRusak = 0;

            if (newCondition == model.BookCondition.DAMAGED) {
                dendaRusak = 50000; // Denda ngerusak barang orang
            } else if (newCondition == model.BookCondition.LOST) {
                dendaRusak = 100000; // Denda ngilangin barang orang
            }

            int totalDenda = dendaTelat + dendaRusak;

            // 4. Catat utang/denda jika ada
            if (totalDenda > 0) {
                person.setUnpaidFees(person.getUnpaidFees() + totalDenda);

                System.out.println("[!] RETURN IRREGULARITY DETECTED");
                System.out.println("    - Overdue Fee (" + weeksOverdue + " weeks): Rp" + dendaTelat);
                System.out.println("    - Damage Fee (" + newCondition + "): Rp" + dendaRusak);
                System.out.println("    => TOTAL FEE: Rp" + totalDenda);
            }

            System.out.println("[SUCCESS] " + person.getFirstName() + " successfully returned: " + book.getTitle());
            System.out.println("[INFO] Remaining Fees for " + person.getFirstName() + ": Rp" + person.getUnpaidFees());

        } else {
            System.out.println("[ERROR] " + person.getFirstName() + " cannot return book '" + book.getTitle()
                    + "' because it was not borrowed by them.");
        }
    }

    public List<Book> filterBooksByGenre(model.Genre genre) {
        return books.stream().filter(b -> b.getGenre() == genre).collect(Collectors.toList());
    }

    public List<Book> filterBooksByAuthor(String authorName) {
        // PENTING: String jangan pake '==' ya, pake .contains() atau
        // .equalsIgnoreCase()
        // Biar kalo nyari "rowling" tetep ketemu "J.K. Rowling"
        return books.stream()
                .filter(b -> b.getAuthor().toLowerCase().contains(authorName.toLowerCase()))
                .collect(Collectors.toList());
    }

    public List<Person> getPersonWithBorrowedBooks() {
        return persons.stream().filter(p -> !p.getBorrowedBooks().isEmpty()).collect(Collectors.toList());
    }

    public List<Person> getPersonWithFees() {
        return persons.stream().filter(p -> p.getUnpaidFees() > 0).collect(Collectors.toList());
    }

    /**
     * Helper khusus buat Case 6 (Return Book).
     * Mencari buku yang ADA DI TAS member (bukan di rak perpus).
     */
    public Book findBookInPersonBag(Person person, String bookTitle) {
        for (Book book : person.getBorrowedBooks()) {
            if (book.getTitle().equalsIgnoreCase(bookTitle)) {
                return book;
            }
        }
        return null;
    }
}
