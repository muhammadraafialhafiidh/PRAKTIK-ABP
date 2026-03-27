const express = require('express');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = 3000;
const DATA_FILE = path.join(__dirname, 'data.json');

// Middleware
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Helper to read data
const readData = () => {
    try {
        const data = fs.readFileSync(DATA_FILE, 'utf8');
        return JSON.parse(data);
    } catch (err) {
        return [];
    }
};

// Helper to write data
const writeData = (data) => {
    fs.writeFileSync(DATA_FILE, JSON.stringify(data, null, 4));
};

// Routes

// 1. Dashboard Page
app.get('/', (req, res) => {
    res.render('index', { title: 'Dashboard', page: 'dashboard' });
});

// 2. Data Table Page
app.get('/data', (req, res) => {
    res.render('data', { title: 'Data Mahasiswa', page: 'data' });
});

// JSON API endpoint for DataTables
app.get('/api/data', (req, res) => {
    const data = readData();
    res.json({ data: data }); // DataTables expects { "data": [...] }
});

// 3. Form Page (for Creating and Updating)
app.get('/form', (req, res) => {
    const id = req.query.id;
    let student = null;
    if (id) {
        const data = readData();
        student = data.find(s => s.id === id);
    }
    res.render('form', { title: student ? 'Edit Data' : 'Tambah Data', page: 'form', student });
});

// POST to create or update
app.post('/save', (req, res) => {
    const { id, nim, name, jurusan } = req.body;
    const data = readData();

    if (id) {
        // Update existing
        const index = data.findIndex(s => s.id === id);
        if (index !== -1) {
            data[index] = { id, nim, name, jurusan };
        }
    } else {
        // Create new
        const newStudent = {
            id: Date.now().toString(),
            nim,
            name,
            jurusan
        };
        data.push(newStudent);
    }

    writeData(data);
    res.redirect('/data');
});

// POST to delete
app.post('/delete/:id', (req, res) => {
    const id = req.params.id;
    let data = readData();
    data = data.filter(s => s.id !== id);
    writeData(data);
    res.redirect('/data');
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
