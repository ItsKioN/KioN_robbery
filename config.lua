Config = {}

-- Config
Config.ButuhPolisi = true -- Atur ke true jika ingin membutuhkan polisi untuk memulai perampokan
Config.MinPolisi = 0  -- jika ButuhPolisi = true, masukkan jumlah minimal polisi untuk bisa merampok
Config.JobPolisi = { 'police' } -- Job Polisi
Config.Dispatch = 'linden_outlawalert' -- Pilih salah satu : 'cd_dispatch', 'linden_outlawalert', 'ps-dispatch', 'qs-dispatch' and 'custom'

-- Config Mesin Kasir
Config.ItemRampok = 'lockpick' -- Kode item yang diperlukan untuk membobol mesin kasir
Config.MinimalCooldown = 10 -- Minimal waktu cooldown bobol kasir setelah dibobol (menit)
Config.MaxCooldown = 20 -- Maksimal waktu cooldown bobol kasir setelah dibobol (menit)
Config.Diffuculty = { 'easy', 'easy', 'easy', 'easy', 'easy','easy', 'easy', 'easy', 'easy', 'easy' } -- Tingkat Kesulitan Skillcheck, bisa diatur 'easy', 'medium' dan 'hard'
Config.Input = { 'W', 'A', 'S', 'D' } -- Tombol yang akan digunakan di skillcheck
Config.DapatUangKasir = 'black_money' -- tipe uang / item yang akan didapatkan setelah berhasil membobol mesin kasir (Atur ke "markedbills" Jika Menggunakan QBCore)
Config.DapatUangKasirRandom = true -- Atur ke true jika ingin mendapatkan jumlah uang random setelah bobol mesin kasih berhasil
Config.JumlahDapatUangKasir = 1000 -- jika DapatUangKasirRandom = false, atur disini berapa jumlah yang akan didapatkan
Config.MinimalDapatUangKasir = 40000 -- jika DapatUangKasirRandom = true, silahkan atur berapa minimal uang kotor yang akan didapatkan
Config.MaksimalDapatUangKasir = 50000 -- jika DapatUangKasirRandom = true, silahkan atur berapa maksimal uang kotor yang akan didapatkan
Config.LockpickHancur = 30 --Presentasi lockpick hancur saat membobol mesin kasir
Config.DapatKodeBrangkas = 100 -- Presentasi Player buat dapat kode brangkas (default : 100)

-- Config Brangkas
Config.MinimalCooldownBrangkas = 10 -- Minimal waktu cooldown bobol brangkas setelah dibobol (menit)
Config.MaksimalCooldownBrangkas = 20 -- Maksimal waktu cooldown bobol brangkas setelah dibobol (menit)
Config.MaksimalInputKode = 3 -- Maksimal input kode brangkas, jika lebih dari itu maka perampokan gagal
Config.DapatUangBrangkas = 'black_money' -- tipe uang / item yang akan didapatkan setelah berhasil membobol brangkas (Atur ke "markedbills" Jika Menggunakan QBCore)
Config.DapatUangBrangkasRandom = true -- Atur ke true jika ingin mendapatkan jumlah uang random setelah bobol brangkas berhasil
Config.JumlahDapatUangBrangkas = 2000 -- Jika DapatUangBrangkasRandom = false, atur disini berapa jumlah yang akan didapatkan
Config.MinimalDapatUangBrangkas = 800000 -- Jika DapatUangBrangkasRandom = true, silahkan atur berapa minimal uang kotor yang akan didapatkan
Config.MaksimalDapatUangBrangkas = 1000000 -- Jika DapatUangBrangkasRandom = true, silahkan atur berapa maksimal uang kotor yang akan didapatkan

-- Store configs
Config.Lokasi = {
    Kasir = {
        vec3(24.9456, -1344.9544, 29.6116),
        vec3(-3041.3566, 584.2665, 8.0235),
        vec3(-3244.5734, 1000.6577, 12.9453),
        vec3(1729.3294, 6417.1230, 35.1519),
        vec3(1698.3787, 4923.2553, 42.2410),
        vec3(1959.3229, 3742.2895, 32.4584),
        vec3(548.9014, 2668.9414, 42.2711),
        vec3(2676.2124, 3280.9694, 55.3558),
        vec3(2554.875, 381.3857, 108.7376),
        vec3(373.5953, 328.5891, 103.6810),
        vec3(-1820.5584, 793.9172, 138.2765),
        vec3(-47.2251, -1757.5423, 29.5983),
        vec3(-706.7102, -913.5667, 19.3929),
        vec3(1164.1452, -322.7899, 69.3824)
    },
    Brangkas = {
        vec3(28.1588, -1338.7192, 28.8068),
        vec3(-3048.2958, 585.4102, 7.2009),
        vec3(-3250.5161, 1004.4418, 12.1558),
        vec3(1734.9835, 6421.3173, 34.3080),
        vec3(1708.1695, 4920.8208, 41.3514),
        vec3(1959.0202, 3749.3291, 31.6847),
        vec3(546.5106, 2662.3266, 41.5089),
        vec3(2672.3398, 3286.8269, 54.6214),
        vec3(2548.7395, 384.8841, 107.9211),
        vec3(378.2658, 333.8557, 102.9076),
        vec3(-1829.5384, 798.4634, 137.5601),
        vec3(-43.8009, -1748.0804, 28.7776),
        vec3(-710.1920, -904.1401, 18.5740),
        vec3(1159.0540, -314.1202, 68.5665)
    }
}

-- Text Config
Notify = {
    title = 'Warung',
    icon = 'store',
    position = 'top',
    CooldownKasir = 'Warung sedang tidak bisa dirampok, coba lagi nanti',
    TidakCukupPolisi = 'Polisi di kota tidak cukup!',
    TidakPunyaLockpick = 'Kamu tidak mempunyai lockpick!',
    LockpickHancur = 'Lockpick Hancur',
    BatalRampok = 'Membatalkan Perampokan',
    PinSalah = 'PIN salah!',
    Error = 'Ada yang tidak beres - coba lagi',
    SeringSalah = 'Kamu terlalu sering salah memasukkan PIN dan gagal merampok'
}

Target = {
    debugTargets = false,
    LabelKasir = 'Bobol Mesin Kasir',
    IconKasir = 'fas fa-lock',
    LabelBrangkas = 'Buka Brangkas',
    IconBrangkas = 'fas fa-key'
}

ProgressCircle = {
    position = 'middle',
    LabelKasir = 'Mengambil uang..',
    registerDuration = 40000,
    LabelBrangkas = 'Mengambil uang..',
    safeDuration = 60000
}

AlertDialog = {
    HeaderKasir = 'Note :',
    TextKasir = 'Kode Brangkas : ',
    TombolKonfirmasi = 'Ok'
}

InputDialog = {
    HeaderBrangkas = 'Brangkas Warung',
    LabelBrangkas = 'Ketik PIN disini',
    DeskripsiBrangkas = 'Silahkan masukkan PIN untuk membuka brangkas',
    ContohKode = '6969',
    IconBrangkas = 'lock'
}