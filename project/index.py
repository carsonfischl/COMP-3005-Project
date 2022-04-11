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


@bp.route("/")
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
        price = request.form["price"]
        error = None

        if not name:
            error = "A name is required."

        if not artist:
            error = "An artist is required."

        if error is not None:
            flash(error)
        else:
            db.execute(
                "INSERT INTO art (name, artist, year, price, user_id, collection_id) VALUES (?, ?, ?, ?, ?, 1)",
                (name, artist, year, price, g.user["id"]),
            )
            db.commit()
            art = db.execute(
                "SELECT * FROM art WHERE user_id = 1"
            ).fetchall()
            return render_template("main/art.html", art=art)

    return render_template("main/create.html", collections = collections)
