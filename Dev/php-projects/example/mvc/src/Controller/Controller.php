<?php

namespace mvc\Controller;
// ISI DI SINI
// 1. Namespace: mvc\Controller
// 2. Class: Controller
// 3. Method: public function view($path, $data = [])
//    - Tugasnya: require_once file view dari folder 'src/View/' . $path . '.php'
class Controller
{
    function view($path, $data = [])
    {
        require_once __DIR__ . '/../View/' . $path . '.php';
    }
}
// HINTS:
// - Pake __DIR__ buat cari folder View.
// - Parameter $data biarin dulu (buat nanti kirim variabel ke view).
