# AquaDesk — Swimming Pool Management & POS

A modern, responsive PHP + MySQL management dashboard for a swimming pool business. AquaDesk combines retail point-of-sale billing, inventory, customer records, swim-session timers, bookings, and sales reporting in one mobile-friendly interface.
Try this project :- https://pool-manegment.free.nf/

## Highlights

- **POS checkout:** product search, cart quantities, walk-in or registered customers, Cash / PhonePe-UPI / Card / Due payment methods, stock deduction, invoice receipt and browser printing.
- **Inventory register:** tubes, caps, goggles, shorts and other items; cost and selling prices, stock counts, low-stock indicators, restocking.
- **Customer management:** customer directory, phone/email/notes and outstanding balances.
- **Swim sessions:** start sessions with duration, live countdown, expiry warning, finish session and history.
- **Bookings:** schedule general swims, lessons, groups, and events; mark booked, arrived, or cancelled.
- **Dashboard & reports:** daily/monthly revenue, due totals, recent transactions, 7-day revenue bars, best-selling items and estimated item profit.
- **Staff roles:** admin and staff accounts; first admin created through one-time setup screen.
- **Responsive UI:** dark navy navigation, violet/aqua accents, cards, mobile layout and printable receipts.
- **Security foundations:** PDO prepared statements, password hashing, session regeneration on login, CSRF checks for POST forms, HTML escaping.

## Stack

PHP 8+ (PDO MySQL), MySQL/MariaDB, HTML, CSS, vanilla JavaScript. Designed for XAMPP and PHP-compatible hosting such as InfinityFree. No Node.js build step required.

## Quick start (XAMPP)

1. Copy this project folder into `C:\xampp\htdocs\pool-pos`.
2. Start Apache and MySQL in XAMPP.
3. Open phpMyAdmin at `http://localhost/phpmyadmin`.
4. Create a database named `pool_pos` (or import `database/schema.sql`, which creates/selects it).
5. Copy `includes/config.example.php` to `includes/config.php`, then set the database host/name/user/password.
6. Open `http://localhost/pool-pos/setup.php`.
7. Create the first admin account using a strong password.
8. Sign in at `http://localhost/pool-pos/login.php`.
9. Optionally import `database/seed_demo.sql` to add sample products for POS testing.
10. **Delete `setup.php` after creating the first admin account.**

### Database configuration

`includes/config.php` should define `DB_HOST`, `DB_NAME`, `DB_USER`, `DB_PASS`, `APP_NAME`, and `APP_TIMEZONE`. Keep this file out of Git. The repository contains only `config.example.php`.

## Deploy to InfinityFree

1. Create the MySQL database in the hosting control panel.
2. Import `database/schema.sql` using the host's phpMyAdmin. If the host does not allow `CREATE DATABASE` / `USE`, create the database first, remove those first two SQL statements, and import the remaining schema into the selected database.
3. Copy `includes/config.example.php` to `includes/config.php`, and set the exact hosted database hostname, database name, username, and password supplied by the host.
4. Upload the application contents into `htdocs` using FTP. Do not upload local database data or secrets.
5. Open `/setup.php` once, create your admin, then delete `setup.php` remotely.
6. Test login, customers, products, POS checkout, stock deduction, invoices, sessions, bookings and reports.

GitHub Pages cannot execute PHP. GitHub is the source-code repository; the live app must run on PHP/MySQL hosting.

## GitHub upload

```bash
git init
git add .
git commit -m "Initial AquaDesk pool POS release"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/pool-management-pos.git
git push -u origin main
```

If the repository already has a remote, use `git remote set-url origin ...` instead of `git remote add origin ...`.

## Demo workflow

1. Create the administrator.
2. Add products in **Inventory** (or import `database/seed_demo.sql`).
3. Add customers in **Customers**.
4. Create a sale in **Point of sale** and print the invoice.
5. Start a swimmer session and view its countdown.
6. Add bookings and explore **Reports**.

## Important limitations and production checklist

This is a portfolio-ready starter, not a certified accounting or pool-safety system. Before real production use:
- enforce role-based permissions on every write operation, not only staff pages;
- add payment reconciliation and a dedicated due-payment collection flow;
- configure automated backups and HTTPS;
- add upload validation/storage only if adding uploaded media;
- add audit logs, rate limiting, stronger error logging, and deployment tests;
- verify timezone/database behavior on your host;
- implement server-side expiry handling if expired sessions must automatically change status;
- review applicable tax invoice requirements before using receipts as official tax invoices.

Do not publish real customer records, passwords, API keys, or production database credentials.

## License

Educational and portfolio use. Add an explicit open-source license if you intend to grant reuse rights.

## Author

**Varshith Reddy Nimma**  
GitHub: https://github.com/Varshith47
