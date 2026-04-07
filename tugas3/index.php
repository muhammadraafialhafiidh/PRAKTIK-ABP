<?php

// Data mahasiswa menggunakan array asosiatif
$mahasiswa = [
    [
        "nama"        => "Ahmad Fauzi",
        "nim"         => "2301010001",
        "nilai_tugas" => 85,
        "nilai_uts"   => 78,
        "nilai_uas"   => 80,
    ],
    [
        "nama"        => "Budi Santoso",
        "nim"         => "2301010002",
        "nilai_tugas" => 60,
        "nilai_uts"   => 55,
        "nilai_uas"   => 58,
    ],
    [
        "nama"        => "Citra Dewi",
        "nim"         => "2301010003",
        "nilai_tugas" => 92,
        "nilai_uts"   => 90,
        "nilai_uas"   => 95,
    ],
    [
        "nama"        => "Dian Pratama",
        "nim"         => "2301010004",
        "nilai_tugas" => 70,
        "nilai_uts"   => 65,
        "nilai_uas"   => 68,
    ],
];

// Function menghitung nilai akhir (Tugas 30%, UTS 30%, UAS 40%)
function hitungNilaiAkhir($tugas, $uts, $uas) {
    return ($tugas * 0.30) + ($uts * 0.30) + ($uas * 0.40);
}

// Function menentukan grade berdasarkan nilai akhir
function tentukanGrade($nilai) {
    if ($nilai >= 85) {
        return "A";
    } elseif ($nilai >= 75) {
        return "B";
    } elseif ($nilai >= 65) {
        return "C";
    } elseif ($nilai >= 55) {
        return "D";
    } else {
        return "E";
    }
}

// Function menentukan status lulus/tidak
function tentukanStatus($nilai) {
    if ($nilai >= 60) {
        return "Lulus";
    } else {
        return "Tidak Lulus";
    }
}

// Hitung nilai akhir, grade, dan status untuk setiap mahasiswa
$totalNilai  = 0;
$nilaiTertinggi = 0;
$namaTertinggi  = "";

foreach ($mahasiswa as &$mhs) {
    $mhs["nilai_akhir"] = hitungNilaiAkhir($mhs["nilai_tugas"], $mhs["nilai_uts"], $mhs["nilai_uas"]);
    $mhs["grade"]       = tentukanGrade($mhs["nilai_akhir"]);
    $mhs["status"]      = tentukanStatus($mhs["nilai_akhir"]);

    $totalNilai += $mhs["nilai_akhir"];

    if ($mhs["nilai_akhir"] > $nilaiTertinggi) {
        $nilaiTertinggi = $mhs["nilai_akhir"];
        $namaTertinggi  = $mhs["nama"];
    }
}
unset($mhs);

$rataRata = $totalNilai / count($mahasiswa);

?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Sistem Penilaian Mahasiswa</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background: #f5f5f5;
            color: #333;
        }

        h1 {
            font-size: 20px;
            margin-bottom: 16px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            background: #fff;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 8px 12px;
            text-align: center;
        }

        th {
            background: #4a90d9;
            color: #fff;
        }

        tr:nth-child(even) {
            background: #f0f4fa;
        }

        .lulus {
            color: green;
            font-weight: bold;
        }

        .tidak-lulus {
            color: red;
            font-weight: bold;
        }

        .info {
            margin-top: 16px;
            background: #fff;
            border: 1px solid #ccc;
            padding: 10px 16px;
            display: inline-block;
        }

        .info p {
            margin: 4px 0;
        }
    </style>
</head>
<body>

    <h1>Sistem Penilaian Mahasiswa</h1>

    <table>
        <thead>
            <tr>
                <th>No</th>
                <th>Nama</th>
                <th>NIM</th>
                <th>Tugas</th>
                <th>UTS</th>
                <th>UAS</th>
                <th>Nilai Akhir</th>
                <th>Grade</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <?php $no = 1; ?>
            <?php foreach ($mahasiswa as $mhs): ?>
            <tr>
                <td><?= $no++ ?></td>
                <td><?= $mhs["nama"] ?></td>
                <td><?= $mhs["nim"] ?></td>
                <td><?= $mhs["nilai_tugas"] ?></td>
                <td><?= $mhs["nilai_uts"] ?></td>
                <td><?= $mhs["nilai_uas"] ?></td>
                <td><?= number_format($mhs["nilai_akhir"], 2) ?></td>
                <td><?= $mhs["grade"] ?></td>
                <td class="<?= $mhs["status"] === 'Lulus' ? 'lulus' : 'tidak-lulus' ?>">
                    <?= $mhs["status"] ?>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>

    <div class="info">
        <p><strong>Rata-rata Kelas:</strong> <?= number_format($rataRata, 2) ?></p>
        <p><strong>Nilai Tertinggi:</strong> <?= number_format($nilaiTertinggi, 2) ?> (<?= $namaTertinggi ?>)</p>
    </div>

</body>
</html>
