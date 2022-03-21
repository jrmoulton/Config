
def hash_one(key):
    return key % 11

def step(key):
    return (key % 9) + 1

def double_hash(key, i):
    return (hash_one(key) + i * step(key)) % 11


