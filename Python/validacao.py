#validar senha
def tamanho(senha):
    minimo = 8
    return len(senha) >= minimo
def minuscula(senha):
    for caractere in senha:
        if caractere.islower():
            return True
    return False
def maiuscula(senha):
    for caractere in senha:
        if caractere.isupper():
            return True
    return False
def digito(senha):
    for caractere in senha:
        if caractere.isdigit():
            return True
    return False
def simbolo(senha):
    simbolos = "!@#$%&*?"
    for caractere in senha:
        if caractere in simbolos:
            return True
    return False
def avaliar_senha(senha):
    criterios = (tamanho(senha), minuscula(senha), maiuscula(senha), digito(senha), simbolo(senha))
    total = sum(criterios)
    if total <= 2:
        return "fraca"
    elif total in (3, 4):
        return "media"
    else:
        return "forte"

#validar email
def email_valido(email):
    correto = 0
    if email.count("@") == 1:
        correto+=1
    return correto

#limpar o cpf e o cnpj
def limpar_documento(documento):
    limpo = ""
    for caractere in documento:
        codigo = ord(caractere)
        if codigo >= 48 and codigo <= 57:
            limpo = limpo + caractere
        elif codigo == 45 or codigo == 46 or codigo == 47:
            continue
        else:
            return None
    return limpo

#validar cpf
def validar_cpf(documento):
    numeros = documento
    # primeiro dígito 
    L1 = 10*numeros[0] + 9*numeros[1] + 8*numeros[2] + 7*numeros[3] + 6*numeros[4] + 5*numeros[5] + 4*numeros[6] + 3*numeros[7] + 2*numeros[8]
    resto1 = L1 % 11
    if resto1 < 2:
        digito_1 = 0
    else:
        digito_1 = 11 - resto1
    if numeros[9] != digito_1:
        return False

    # segundo dígito 
    L2 = 11*numeros[0] + 10*numeros[1] + 9*numeros[2] + 8*numeros[3] + 7*numeros[4] + 6*numeros[5] + 5*numeros[6] + 4*numeros[7] + 3*numeros[8] + 2*numeros[9]
    resto2 = L2 % 11
    if resto2 < 2:
        digito_2 = 0
    else:
        digito_2 = 11 - resto2
    if numeros[10] != digito_2:
        return False
    return True

def validar_cnpj(cnpj):
    numeros = cnpj
    # primeiro dígito
    L1 = 5*numeros[0] + 4*numeros[1] + 3*numeros[2] + 2*numeros[3] + 9*numeros[4] + 8*numeros[5] + 7*numeros[6] + 6*numeros[7] + 5*numeros[8] + 4*numeros[9] + 3*numeros[10] + 2*numeros[11]
    resto1 = L1 % 11
    if resto1 < 2:
        digito_1 = 0
    else:
        digito_1 = 11 - resto1
    if numeros[12] != digito_1:
        return False

    # segundo dígito
    L2 = 6*numeros[0] + 5*numeros[1] + 4*numeros[2] + 3*numeros[3] + 2*numeros[4] + 9*numeros[5] + 8*numeros[6] + 7*numeros[7] + 6*numeros[8] + 5*numeros[9] + 4*numeros[10] + 3*numeros[11] + 2*numeros[12]
    resto2 = L2 % 11
    if resto2 < 2:
        digito_2 = 0
    else:
        digito_2 = 11 - resto2
    if numeros[13] != digito_2:
        return False
    return True