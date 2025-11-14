import re

def validar_cpf(cpf):
    cpf = re.sub('[^0-9]', '', cpf)
    if len(cpf) != 11 or cpf == cpf[0] * 11:
        return False
    
    def calc_digito(digs):
        s = sum(int(d) * i for d, i in zip(digs, range(len(digs)+1, 1, -1)))
        resto = (s * 10) % 11
        return 0 if resto == 10 else resto
    
    dig1 = calc_digito(cpf[:9])
    dig2 = calc_digito(cpf[:10])
    return dig1 == int(cpf[9]) and dig2 == int(cpf[10])

def validar_email(email):
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$'
    return re.match(pattern, email) is not None

def validar_telefone(telefone):
    telefone = re.sub('[^0-9]', '', telefone)
    return len(telefone) == 11
