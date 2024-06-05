import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from glob import glob

#-----Money evolution-----
def money_graph():
    column = ["Player 1", "Player 2"]
    file = glob('Donnees/2pl_MoneyEvolution*.csv')[0]
    moneyEvo = pd.read_csv(file, usecols = column)
    #Reverses dataframes
    moneyEvo = moneyEvo[::-1].reset_index()
    #Plots money evolution
    plt.plot(moneyEvo['Player 1'], label = "Joueur 1")
    plt.plot(moneyEvo['Player 2'], label = "Joueur 2")
    #Plots floor
    plt.axhline(y=0, linewidth = 2,  color='r', linestyle = 'dotted', label = "Plancher")
    #Names axis
    plt.ylabel("Argent")

#-----Pos Frequency------
def freq2pl_graph():
    fig, (ax1, ax2) = plt.subplots(2)
    freq_pl1 = pd.read_csv('player1_test_2pl_frequences.csv')
    freq_pl2 = pd.read_csv('player2_test_2pl_frequences.csv')
    ax1.barh(freq_pl1["Case"], freq_pl1["Frequence"], height = 0.5)
    ax2.barh(freq_pl2["Case"], freq_pl2["Frequence"], height = 0.5)
    ax1.set_title('Positions du joueur 1')
    ax2.set_title('Positions du joueur 2')
    plt.subplots_adjust(hspace=0.4)

def freq_graph ():
    fig, ax = plt.subplots()
    freq = pd.read_csv('Donnees/freqCase.csv')
    ax.bar(freq["Case"], freq["Frequence"], width = 0.5)
    ax.set_title('Répartition de positions sur le plateau')

def col_graph ():
    fig, ax = plt.subplots()
    freq = pd.read_csv('Donnees/freqCouleur.csv')
    bar_colors = ['tab:brown', 'deepskyblue', 'deeppink', 'tab:orange', 'tab:red', 'yellow', 'tab:green', 'royalblue']
    ax.bar(freq["Couleur"], freq["Frequence"], color = bar_colors)


#------Pos Probability-----
def prob_graph():
    fig, (ax1, ax2) = plt.subplots(2)
    prob_pl1 = pd.read_csv('player1_test_2pl_probabilités.csv')
    prob_pl2 = pd.read_csv('player2_test_2pl_probabilités.csv')
    ax1.bar(prob_pl1["Case"], prob_pl1["Probabilité"])
    ax2.bar(prob_pl1["Case"], prob_pl2["Probabilité"])

money_graph()

plt.legend()
plt.show()
