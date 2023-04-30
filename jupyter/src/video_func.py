"""
Archivo donde se ubican las funciones que se usarán para el proyecto de 
MySQL de la 3ª semana de IRONHACK

"""
import pandas as pd
import numpy as np


def check_nan_cols(df: pd.DataFrame(),
                   method='sum',
                   disp=True) -> pd.Series():
    """
    check_nan_cols: recibe un dataframe y retorna un Serie, con el número de 
    nulos por cada columna del dataframe (method = sum), o el porcentaje 
    (method = 'avg').
    Si se asigna a una variable, muestra el resultado con las columnas que
    tengan nulos, a menos que se indique lo contrario (display = False)

    """

    if method == 'sum':
        nan_cols = df.isna().sum()
    elif method == 'avg':
        nan_cols = round(df.isna().mean()*100, 2)
    if disp == True:
        display(nan_cols[nan_cols > 0])

    return nan_cols


def cols_info(df: pd.DataFrame) -> pd.DataFrame:
    """
    Devulve información detallada de cada columna

    """
    cols_info = dict()
    for col in df:
        info = dict()
        info['Col Type'] = df[col].dtype
        info['Nulos'] = int(check_nan_cols(df[col], disp=False))
        info['str'] = df[col][df[col].apply(lambda x: type(x) == str)].shape[0]
        info['float'] = df[col][df[col].apply(
            lambda x: type(x) == float)].shape[0]
        info['int'] = df[col][df[col].apply(lambda x: type(x) == int)].shape[0]
        info['bool'] = df[col][df[col].apply(
            lambda x: type(x) == bool)].shape[0]
        info['date'] = df[col][df[col].apply(
            lambda x: type(x) == np.datetime64)].shape[0]
        info['float==nan'] = info['Nulos'] == info['float']
        info['unique'] = df[col].unique().size
        info['unique %'] = round(info['unique'] / df.shape[0] * 100, 2)
        cols_info[col] = info
    df = pd.DataFrame(cols_info).T

    # Devolvemos únicamente que tengan algún valor distinto de cero
    return df.loc[:, (df != 0).any()]


def new_customer_id(_id_old, cust):
    """
    Función que convierte el antiguo customer_id al nuevo valor de la nueva
    DB
    """
    def get_id(serie):
        return serie[-1]
    # list_id serie cuyos indices es el nuevo id y valores old_id
    list_id = cust.Name.str.split('_').apply(get_id).apply(np.int16)
    return list_id.index[list_id == _id_old][0] + 1
