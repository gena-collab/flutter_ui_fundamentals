# Tahap 11 — Membuat Tabel Database Courses

## Struktur Tabel
- id: bigint identity, primary key
- code: text
- title: text
- credits: int
- status: text
- created_at: timestamptz

## Data Awal
1. PTI101 — Pemrograman Dasar — 3 SKS — done
2. PTI102 — Pemrograman Berbasis Web — 3 SKS — active
3. PTI103 — Basis Data — 3 SKS — planned

## Catatan
Tabel courses dibuat pada Supabase dan diisi dengan tiga data awal. Kolom id dan created_at menggunakan nilai otomatis. Pengaturan RLS dan policy disesuaikan dengan kebutuhan praktikum.

## Bukti Praktikum
Screenshot dashboard Supabase ditempelkan pada worksheet Tahap 11.
