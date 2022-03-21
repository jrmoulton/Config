import math

iterations = 1000000
def run():
    import random
    total_collisions = 0
    for _ in range(iterations):
        elements = [True]*100
        for _ in range(25):
            spot = random.randrange(0,100)
            if elements[spot]:
                elements[spot] = False
            else:
                total_collisions += 1
                break
    return total_collisions

num = run() / iterations
perc = num * 10000
perc = math.floor(perc)
perc = perc / 100
print(f"{perc}%")

