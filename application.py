#!/usr/bin/env python3

import sys
from tkinter import Tk, Label

def main():
    root = Tk()
    root.geometry("250x100")
    root.title("GUI Application")

    message = "Hello world!"
    if len(sys.argv) > 1:
        message = sys.argv[1]

    msgLabel = Label(root, text=message)
    msgLabel.pack()

    root.mainloop()

if __name__ == "__main__":
    main()
