import numpy as np
import pandas as pd
from glob import glob

def getWinner(file):
    column = ["Player 1", "Player 2"]
    moneyEvo = pd.read_csv(file, usecols = column)
    if moneyEvo['Player 1'][0] > 0:
        return 1
    else:
        return 2 

def printWinners():
    for file in glob('Donnees/2pl_MoneyEvolution*.csv'):
        print(getWinner(file))

def winRate():
    winsPl1 = 0
    for file in glob('Donnees/2pl_MoneyEvolution*.csv'):
        if getWinner(file) == 1:
            winsPl1 += 1
    pl1Wr = winsPl1/len(glob('Donnees/2pl_MoneyEvolution*.csv')) *100
    print("Player 1 winrate:", pl1Wr)
    print("Player 2 winrate:", 100-pl1Wr)


winRate()