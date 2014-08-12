#!/usr/bin/env python

from sys import argv, exit

def match(desk, word):
    if desk == "": return False
    if word == "": return True

    w = word[0]
    ws = word[1:]
    if w in desk:
        return match(desk.replace(w, '', 1), ws)

    if '*' in desk:
        return match(desk.replace('*', '', 1), ws)

    return False

def search(tokens, dictionary):
    return [word for word in dictionary if match(tokens, word)]

def prettyPrint(words):
    print "\n".join(sorted(words, key=len))

if __name__ == '__main__':
    if len(argv) == 2:
        firstArg = argv[1]
    else:
        exit("One parameter needed")

    dictionary = open("ODS6.txt", "r").read().splitlines()

    results = search(firstArg.upper(), dictionary)

    prettyPrint(results)

