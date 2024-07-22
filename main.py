from fastapi import FastAPI, HTTPException

from typing import Union
from pydantic import BaseModel

import pygments
import pygments.formatters
import pygments.lexers
import pygments.util
from starlette.responses import JSONResponse

__version = '1.0.0'

app = FastAPI()

class CSSRequest(BaseModel):
    formatter: str = 'html'
    classname: str = 'highlight'

class HighlightRequest(BaseModel):
    code: str
    lexer: str
    formatter: str = 'html'
    options: dict = {}


class Response(BaseModel):
    result: str


class VersionResponse(BaseModel):
    server: str
    pygments: str


@app.get('/version')
def version() -> VersionResponse:
    return VersionResponse(
        server=__version,
        pygments=pygments.__version__
    )


@app.post('/highlight')
def highlight(request: HighlightRequest) -> Response:
    try:
        lexer = pygments.lexers.get_lexer_by_name(request.lexer, **request.options)
        formatter = pygments.formatters.get_formatter_by_name(request.formatter, **request.options)

        result = pygments.highlight(request.code, lexer, formatter)

        return Response(result=result)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
