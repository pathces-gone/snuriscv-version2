from os import path

class Env():
    TRACE_GEN_PATH= path.join( path.abspath(path.dirname(__file__)), '..', 'build','trace')


if __name__ == '__main__':
    pass