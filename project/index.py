from flask import Blueprint
from flask import g
from flask import redirect
from flask import render_template
from flask import url_for
from flask import request
from flask import flash

from project.auth import login_required
from project.db import get_db

bp = Blueprint("index", __name__)


@bp.route("/", methods=("GET", "POST"))
def index():
    user = g.user
    if g.user is None:
        return redirect(url_for("auth.login"))
    else:
        db = get_db()
        art = db.execute(
            "SELECT * FROM art WHERE user_id = 1"
        ).fetchall()
    return render_template("main/art.html", art=art)

@bp.route("/create", methods=("GET", "POST"))
@login_required
def create():
    db = get_db()
    collections = db.execute(
            "SELECT * FROM collection WHERE user_id = ?", (g.user["id"],)
        ).fetchall()
    if request.method == "POST":
        name = request.form["name"]
        artist = request.form["artist"]
        year = request.form["year"]
        collection = request.form["collection"]
        error = None

        if not name:
            error = "A name is required."

        if not artist:
            error = "An artist is required."

        if error is not None:
            flash(error)
        else:
            db.execute(
                "INSERT INTO art (name, artist, year, user_id, collection) VALUES (?, ?, ?, ?, ?)",
                (name, artist, year, g.user["id"], collection),
            )
            db.commit()
            art = db.execute(
                "SELECT * FROM art WHERE user_id = 1"
            ).fetchall()
            return render_template("main/art.html", art=art)

    return render_template("main/create.html", collections = collections)

@bp.route("/artist/<int:id>", methods=("GET", "POST"))
@login_required
def artist(id):
    db = get_db()
    artist = db.execute(
        "SELECT name FROM artist WHERE id = ?", (id,)
    ).fetchone()[0]
    print(artist)
    art = db.execute("SELECT * FROM art WHERE artist = ?", (artist,)).fetchall()
    return render_template("main/art.html", art=art)

@bp.route("/collection/<int:id>", methods=("GET", "POST"))
@login_required
def genre(id):
    db = get_db()
    collection = db.execute("SELECT name FROM collection WHERE id = ?", (id,)).fetchone()[0]
    art = db.execute("SELECT * FROM art WHERE collection = ?", (collection,)).fetchall()
    return render_template("main/art.html", art=art)

@bp.route("/club/<int:id>", methods=("GET", "POST"))
@login_required
def club(id):
    db = get_db()
    club = db.execute("SELECT name FROM collector WHERE collector.id IN(SELECT user_id FROM collection JOIN club ON club.name=collection.name WHERE club.id=?)", (id,)).fetchall()
    return render_template("main/club.html", art=club)