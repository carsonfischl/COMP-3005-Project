from flask import Blueprint
from flask import g
from flask import redirect
from flask import render_template
from flask import url_for
from flask import request
from flask import flash

from project.auth import login_required
from project.db import get_db

bp = Blueprint("club", __name__)

@bp.route("/", methods=("GET", "POST"))
def club():
    user = g.user
    if g.user is None:
        return redirect(url_for("auth.login"))
    else:
        db = get_db()
        art = db.execute(
            "SELECT * FROM art WHERE user_id = 1"
        ).fetchall()
    return render_template("main/club.html", art=art)