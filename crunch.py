import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

#-----Money evolution-----
def money_graph():
    column = ["Money"]
    money_pl1 = pd.read_csv('player1_test_2pl_money.csv', usecols = column)
    money_pl2 = pd.read_csv('player2_test_2pl_money.csv', usecols = column)
    #Reverses dataframes
    money_pl1 = money_pl1[::-1].reset_index()
    money_pl2 = money_pl2[::-1].reset_index()
    #Plots money evolution
    plt.plot(money_pl1['Money'], label = "Joueur 1")
    plt.plot(money_pl2['Money'], label = "Joueur 2")
    #Plots floor
    plt.axhline(y=0, linewidth = 2,  color='r', linestyle = 'dotted', label = "Plancher")
    #Names axis
    plt.ylabel("Argent")

#-----Pos Frequency------
def freq_graph():
    fig, (ax1, ax2) = plt.subplots(2)
    freq_pl1 = pd.read_csv('player1_test_2pl_frequences.csv')
    freq_pl2 = pd.read_csv('player2_test_2pl_frequences.csv')
    ax1.barh(freq_pl1["Case"], freq_pl1["Frequence"], height = 0.5)
    ax2.barh(freq_pl2["Case"], freq_pl2["Frequence"], height = 0.5)
    ax1.set_title('Positions du joueur 1')
    ax2.set_title('Positions du joueur 2')
    plt.subplots_adjust(hspace=0.4)

#------Pos Probability-----
def prob_graph():
    fig, (ax1, ax2) = plt.subplots(2)
    prob_pl1 = pd.read_csv('player1_test_2pl_probabilités.csv')
    prob_pl2 = pd.read_csv('player2_test_2pl_probabilités.csv')
    ax1.bar(prob_pl1["Case"], prob_pl1["Probabilité"])
    ax2.bar(prob_pl1["Case"], prob_pl2["Probabilité"])

plt.legend()
plt.show()
