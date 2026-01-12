package model;

/**
 * Merepresentasikan Sebuah objek buku di perpustakaan.
 * Class ini menyimpan informasi detail buku dan mendukung pengurutan
 * berdasarkan judul.
 * 
 * @author Ferdinand
 */
public class Book implements Comparable<Book> {
    private String title;
    private String author;
    private Genre genre;
    private BookCondition condition;

    /**
     * Membuat object Buku baru.
     * 
     * @param title     Judul buku
     * @param author    Penulis buku
     * @param genre     Genre buku (Category)
     * @param condition Kondisi fisik buku saat ini
     */
    public Book(String title, String author, Genre genre, BookCondition condition) {
        this.title = title;
        this.author = author;
        this.genre = genre;
        this.condition = condition;
    }

    /**
     * Mengambil judul buku.
     * 
     * @return Judul buku
     */
    public String getTitle() {
        return title;
    }

    /**
     * Mengubah judul buku.
     * 
     * @param title Judul buku baru
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * Mengambil nama penulis.
     * 
     * @return Nama penulis
     */
    public String getAuthor() {
        return author;
    }

    /**
     * Mengubah nama penulis.
     * 
     * @param author Nama penulis baru
     */
    public void setAuthor(String author) {
        this.author = author;
    }

    /**
     * Mengambil genre buku.
     * 
     * @return Genre buku
     */
    public Genre getGenre() {
        return genre;
    }

    /**
     * Mengubah genre buku.
     * 
     * @param genre Genre baru
     */
    public void setGenre(Genre genre) {
        this.genre = genre;
    }

    /**
     * Mengambil kondisi buku saat ini.
     * 
     * @return Kondisi buku
     */
    public BookCondition getCondition() {
        return condition;
    }

    /**
     * Mengubah kondisi buku.
     * 
     * @param condition Kondisi baru (misal: dari GOOD jadi DAMAGED)
     */
    public void setCondition(BookCondition condition) {
        this.condition = condition;
    }

    /**
     * Mengembalikan informasi buku dalam bentuk String.
     * Format: "Judul by Penulis [Genre] (Kondisi)"
     */
    @Override
    public String toString() {
        return title + " by " + author + " [ " + genre + " ] ( " + condition + " )";
    }

    /**
     * Membandingkan buku ini dengan buku lain berdasarkan JUDUL.
     * Digunakan untuk sorting otomatis.
     * 
     * @param otherBook Buku lain yang mau dibandingin
     * @return Angka negatif (sebelum), 0 (sama), atau positif (setelah)
     */
    @Override
    public int compareTo(Book otherBook) {
        return this.title.compareToIgnoreCase(otherBook.title);
    }
}
