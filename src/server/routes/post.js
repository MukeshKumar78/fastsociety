const router = require('express').Router({mergeParams: true});
const config = require('../config');
const { getMultiple } = require('../db/post');

router.get('/', (req, res) => {
    const { eventId } = req.params;
    const count = +req.query.count || 5, offset = +req.query.offset || 0;

    getMultiple({where: {Event_id: eventId}, offset: offset, limit: count}, 
        (errors, results) => {
            if(errors)
                res.status(500).send(errors);
            res.status(200).json(results);
        }
    );
});

module.exports = router;