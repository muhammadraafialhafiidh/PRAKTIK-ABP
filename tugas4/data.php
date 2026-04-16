<?php
// Set header agar browser tahu bahwa response ini adalah JSON
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

// "Database sederhana" berbentuk array PHP
$profil = [
    [
        'nama'      => 'Budi Santoso',
        'pekerjaan' => 'Web Developer',
        'lokasi'    => 'Jakarta',
        'email'     => 'budi@example.com',
        'avatar'    => 'BS'
    ],
    [
        'nama'      => 'Sari Dewi',
        'pekerjaan' => 'UI/UX Designer',
        'lokasi'    => 'Bandung',
        'email'     => 'sari@example.com',
        'avatar'    => 'SD'
    ],
    [
        'nama'      => 'Ahmad Fauzi',
        'pekerjaan' => 'Data Scientist',
        'lokasi'    => 'Surabaya',
        'email'     => 'ahmad@example.com',
        'avatar'    => 'AF'
    ],
    [
        'nama'      => 'Nina Rahayu',
        'pekerjaan' => 'Backend Engineer',
        'lokasi'    => 'Yogyakarta',
        'email'     => 'nina@example.com',
        'avatar'    => 'NR'
    ]
];

// Ubah array PHP menjadi format JSON lalu tampilkan
echo json_encode($profil);
?>
