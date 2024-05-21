from flask import Blueprint, jsonify, abort, request
from ..models import User, db, Tweet, likes_table
import hashlib
import secrets

import sqlalchemy
stmt = sqlalchemy.insert(likes_table).values(name='spongebob', fullname="Spongebob Squarepants")

def scramble(password: str):
    """Hash and salt the given password"""
    salt = secrets.token_hex(16)
    return hashlib.sha512((password + salt).encode('utf-8')).hexdigest()

bp = Blueprint('users', __name__, url_prefix='/users')

@bp.route('', methods=['GET']) 
def index():
    users = User.query.all() 
    result = []
    for u in users:
        result.append(u.serialize()) 
    return jsonify(result) 

@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    u = User.query.get_or_404(id)
    return jsonify(u.serialize())

@bp.route('', methods=['POST'])
def create():
    if 'username' not in request.json or 'password' not in request.json:
        return abort(400)
    if len(request.json['username']) < 3 or len(request.json['password']) < 8:
        return abort(400)
    u = User(
        username=request.json['username'],
        password=scramble(request.json['password'])
    )
    db.session.add(u)
    db.session.commit()
    return jsonify(u.serialize())

@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    u = User.query.get_or_404(id)
    try:
        db.session.delete(u) 
        db.session.commit() 
        return jsonify(True)
    except:
        return jsonify(False)

@bp.route('/<int:id>', methods=['PATCH','PUT'])
def update(id: int):
    u = User.query.get_or_404(id)
    if 'username' not in request.json and 'password' not in request.json:
        return abort(400)
    if 'username' in request.json:
        if len(request.json['username']) >= 3:
            u.username = request.json['username']
        else:
            return abort(400)

    if 'password' in request.json:
        if len(request.json['password']) >= 8:
            u.password = scramble(request.json['password'])
        else:
            return abort(400)
    try:
        db.session.commit()
        return jsonify(u.serialize())
    except:
        return jsonify(False)

@bp.route('/<int:id>/liked_tweets', methods=['GET'])
def liked_tweets(id: int):
    u = User.query.get_or_404(id)
    result = []
    for t in u.liked_tweets:
        result.append(t.serialize())
    return jsonify(result)
#bonus task, test ok, second like attempt=false
@bp.route('/<int:id>/likes', methods=['POST'])
def like(id: int):
    if 'tweet_id' not in request.json:
        return abort(400)
    u = User.query.get_or_404(id)
    t = Tweet.query.get_or_404(request.json['tweet_id'])
    if t in u.liked_tweets:
        return jsonify(False)
    u.liked_tweets.append(t)
    db.session.commit()
    return jsonify(t.serialize())
#bonus task 2, test ok, second req returns false
@bp.route('/<int:id>/likes', methods=['DELETE'])
def unlike(id: int):
    if 'tweet_id' not in request.json:
        return abort(400)
    u = User.query.get_or_404(id)
    t = Tweet.query.get_or_404(request.json['tweet_id'])
    if t not in u.liked_tweets:
        return jsonify(False)
    u.liked_tweets.remove(t)
    db.session.commit()
    return jsonify(True)
