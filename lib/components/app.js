const express = require('express');
const mongoose = require('mongoose');

const app = express();
const port = 3000;



mongoose.connect('mongodb://localhost/friendsdb', { useNewUrlParser: true, useUnifiedTopology: true });


app.use(express.json());


const FriendSchema = new mongoose.Schema({
    name: String,
    email: String,
});

const Friend = mongoose.model('Friend', FriendSchema);
os
app.get('/friends', async (req, res) => {
    const friends = await Friend.find();
    res.json(friends);
});


app.post('/friends', async (req, res) => {
    const friend = new Friend(req.body);
    await friend.save();
    res.status(201).json(friend);
});


app.delete('/friends/:id', async (req, res) => {
    await Friend.findByIdAndDelete(req.params.id);
    res.status(204).send();
});

app.listen(port, () => {
    console.log(`API de amigos rodando em http://localhost:${port}`);
});
