from unittest.mock import patch
import app as m

def test_index():
    with patch.object(m, "r") as fake:
        fake.incr.return_value = 5
        resp = m.app.test_client().get("/")
        assert resp.status_code == 200
        assert b"5 fois" in resp.data