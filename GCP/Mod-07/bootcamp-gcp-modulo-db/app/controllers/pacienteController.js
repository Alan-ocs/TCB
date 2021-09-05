const controller = {};

controller.list = (req, res) => {
    req.getConnection((err, conn) => {
        conn.query('SELECT * FROM paciente', (err, pacientes) => {
            if (err) {
                res.json('Ops, falha ao carregar...Tente novamente em 2 minutos.');
            }
            res.render('pacientes', {
                data: pacientes
            });
        });
    });
};

controller.save = (req, res) => {
    const data = req.body;
    console.log(req.body);
    req.getConnection((err, connection) => {
        const query = connection.query('INSERT INTO paciente set ?', data, (err, paciente) => {
            console.log(paciente);
            res.redirect('/');
        })
    })
};

controller.edit = (req, res) => {
    const {id} = req.params;
    req.getConnection((err, conn) => {
        conn.query("SELECT * FROM paciente WHERE id = ?", [id], (err, rows) => {
            res.render('pacientes_edit', {
                data: rows[0]
            })
        });
    });
};

controller.update = (req, res) => {
    const {id} = req.params;
    const newpaciente = req.body;
    req.getConnection((err, conn) => {

        conn.query('UPDATE paciente set ? where id = ?', [newpaciente, id], (err, rows) => {
            res.redirect('/');
        });
    });
};

controller.delete = (req, res) => {
    const {id} = req.params;
    req.getConnection((err, connection) => {
        connection.query('DELETE FROM paciente WHERE id = ?', [id], (err, rows) => {
            res.redirect('/');
        });
    });
};

module.exports = controller;
