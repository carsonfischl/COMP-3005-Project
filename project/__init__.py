import os

from flask import Flask


def create_app(test_config=None):
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        SECRET_KEY="dev",
        DATABASE=os.path.join(app.instance_path, "art.db"),
    )

    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    from project import db

    db.init_app(app)

    from project import auth, index

    app.register_blueprint(index.bp)
    app.register_blueprint(auth.bp)

    app.add_url_rule("/", endpoint="index")

    return app
