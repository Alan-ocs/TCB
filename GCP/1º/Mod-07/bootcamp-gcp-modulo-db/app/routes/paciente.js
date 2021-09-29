const router = require('express').Router();

const pacienteController = require('../controllers/pacienteController');

router.get('/', pacienteController.list);
router.post('/add', pacienteController.save);
router.get('/update/:id', pacienteController.edit);
router.post('/update/:id', pacienteController.update);
router.get('/delete/:id', pacienteController.delete);

module.exports = router;
