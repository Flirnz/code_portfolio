import model.*;
import service.LibraryService;
import java.util.Scanner;

public class Main {

    // --- METHOD UTAMA (Pintu Masuk Aplikasi) ---
    public static void main(String[] args) {
        // 1. SETUP: Bikin Service & Data Awal
        LibraryService perpusGw = new LibraryService();
        initData(perpusGw); // <--- Panggil "Asisten" buat isi data biar gak kosong

        Scanner scanner = new Scanner(System.in);
        boolean isRunning = true;

        // 2. LOOP MENU (Program gak mati sampe user pilih Keluar)
        while (isRunning) {
            System.out.println("\n=== 📚 LIBRARY MANAGEMENT SYSTEM 📚 ===");
            System.out.println("1. List All Books");
            System.out.println("2. List All Members");
            System.out.println("3. Add New Member");
            System.out.println("4. Add New Book");
            System.out.println("5. Borrow Book");
            System.out.println("6. Return Book");
            System.out.println("0. Exit");
            System.out.print("Select Menu: ");

            String input = scanner.nextLine();

            // SEMENTARA: Kita bikin kerangka menunya dulu
            switch (input) {
                case "1":
                    System.out.println("\n--- Book Catalog ---");
                    perpusGw.getBooks().forEach(System.out::println);
                    break;
                case "2":
                    System.out.println("\n--- Member List ---");
                    perpusGw.getPersons().forEach(System.out::println);
                    break;
                case "3":
                    System.out.println("\n--- Add New Member ---");
                    System.out.print("First Name: ");
                    String fName = scanner.nextLine();
                    System.out.print("Last Name: ");
                    String lName = scanner.nextLine();
                    System.out.print("Birth Date (DD.MM.YYYY): ");
                    String bDate = scanner.nextLine();
                    System.out.print("City: ");
                    String city = scanner.nextLine();
                    Address newAdd = new Address("-", "-", "-", city);
                    Person newMember = new Person(fName, lName, bDate, newAdd);
                    perpusGw.registerPerson(newMember);
                    break;

                case "4":
                    System.out.println("\n--- Add New Book ---");
                    System.out.print("Title: ");
                    String judul = scanner.nextLine();
                    System.out.print("Author: ");
                    String author = scanner.nextLine();
                    System.out.print("Genre (NOVEL, FANTASY, THRILLER, etc): ");
                    String genreStr = scanner.nextLine().toUpperCase();
                    Genre genre = Genre.valueOf(genreStr);
                    System.out.print("Condition (NEW, GOOD, DAMAGED): ");
                    String bookCon = scanner.nextLine().toUpperCase();
                    BookCondition bookCondition = BookCondition.valueOf(bookCon);
                    Book newBook = new Book(judul, author, genre, bookCondition);
                    perpusGw.addBook(newBook);
                    break;

                case "5":
                    System.out.println("\n--- Borrow Book ---");
                    System.out.print("Borrower Name: ");
                    String borrowerName = scanner.nextLine();
                    Person borrower = perpusGw.findPersonByName(borrowerName);
                    if (borrower == null) {
                        System.out.println("❌ Error: Member not found.");
                        break;
                    }
                    System.out.print("Book Title: ");
                    String bookTitleToBorrow = scanner.nextLine();
                    Book bookToBorrow = perpusGw.findBookByTitle(bookTitleToBorrow);
                    if (bookToBorrow == null) {
                        System.out.println("❌ Error: Book not found.");
                        break;
                    }
                    perpusGw.borrowBooks(borrower, bookToBorrow);
                    break;

                case "6":
                    System.out.println("\n--- Return Book ---");
                    System.out.print("Borrower Name: ");
                    String returnerName = scanner.nextLine();
                    Person returner = perpusGw.findPersonByName(returnerName);
                    if (returner == null) {
                        System.out.println("❌ Error: Member not found.");
                        break;
                    }

                    // 2. Validasi Buku
                    System.out.print("Book Title: ");
                    String returnedTitle = scanner.nextLine();
                    Book returnedBook = perpusGw.findBookInPersonBag(returner, returnedTitle);
                    if (returnedBook == null) {
                        System.out.println("❌ Error: Book not found.");

                        break;
                    }
                    // 3. Input Data Denda
                    System.out.print("Weeks Overdue (0 if on time): ");
                    int weeks = Integer.parseInt(scanner.nextLine());

                    System.out.print("Condition (GOOD, DAMAGED, LOST): ");
                    String condStr2 = scanner.nextLine().toUpperCase();
                    BookCondition returCondition = BookCondition.valueOf(condStr2);

                    // EXECUTE RETURN
                    perpusGw.returnBook(returner, returnedBook, weeks, returCondition);
                    break;

                case "0":
                    System.out.println("Exiting system. Goodbye! 👋");
                    isRunning = false;
                    break;
                default:
                    System.out.println("❌ Invalid input. Please enter 0-6.");
            }
        }
        scanner.close(); // Tutup scanner biar rapi & gak bocor memory
    }

    // --- METHOD ASISTEN (Helper) ---
    // Ini fungsinya cuma buat menuh-menuhin data awal doang.
    // Ditaruh di sini (di luar main) biar kodingan 'main' tetep rapi & pendek.
    private static void initData(LibraryService service) {
        System.out.println("⚙️  Sedang mengisi rak buku & database member...");

        // Isi Buku
        service.addBook(new Book("Harry Potter", "JK Rowling", Genre.FANTASY, BookCondition.GOOD));
        service.addBook(new Book("Atomic Habits", "James Clear", Genre.NOVEL, BookCondition.GOOD));
        service.addBook(new Book("Sherlock Holmes", "Conan Doyle", Genre.CRIME, BookCondition.DAMAGED));

        // Isi Buku Lengkap (Yang lu suka tadi)
        service.addBook(new Book("Lord of the Rings", "J.R.R. Tolkien", Genre.FANTASY, BookCondition.NEW));
        service.addBook(new Book("Clean Code", "Robert C. Martin", Genre.PROGRAMMING, BookCondition.NEW));
        service.addBook(new Book("The Martian", "Andy Weir", Genre.SCIENCE_FICTION, BookCondition.GOOD));

        // Isi Member
        Address alamatku = new Address("Jl.Sudirman", "19", "11111", "Jakarta");
        Person aku = new Person("Ferdinand", "Stark", "22.04.2001", alamatku);

        Address alamatDia = new Address("Jl.Antasari", "21", "222222", "Lampung");
        Person dia = new Person("Arnold", "Stark", "17.03.1992", alamatDia);

        service.registerPerson(aku);
        service.registerPerson(dia);
    }
}