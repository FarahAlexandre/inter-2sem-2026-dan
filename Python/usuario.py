import validacao

def cadastrar_usuario(cpfs, cnpjs, nomes, emails, senhas, enderecos):
    
    nome = str(input("Digite seu nome ou nome da empresa: "))
    documento = validacao.limpar_documento(input("Digite, somente os números do seu CPF ou CNPJ: "))

    while True:
        if documento is None:
            print("O CPF ou CNPJ contém caracteres inválidos")
            documento = validacao.limpar_documento(input("Por favor, digite novamente: "))
            continue
        if len(documento) == 11:
            numeros_limpos = []
            for caractere in documento:
                numeros_limpos.append(int(caractere))
            if not validacao.validar_cpf(numeros_limpos):
                print("O CPF digitado está incorreto")
                documento = validacao.limpar_documento(input("Por favor, digite novamente: "))
                continue
            if documento in cpfs:
                print("CPF já cadastrado")
                return
            cpfs.append(documento)
            break
        elif len(documento) == 14:
            numeros_limpos = []
            for caractere in documento:
                numeros_limpos.append(int(caractere))
            if not validacao.validar_cnpj(numeros_limpos):
                print("O CNPJ digitado está incorreto")
                documento = validacao.limpar_documento(input("Por favor, digite novamente: "))
                continue
            if documento in cnpjs:
                print("CNPJ já cadastrado")
                return
            cnpjs.append(documento)
            break
        else:
            print("O CPF ou CNPJ está inválido")
            documento = validacao.limpar_documento(input("Por favor, digite novamente: "))
    
    email = str(input("Digite seu e-mail: "))
    while True:
        triagem_email = validacao.email_valido(email)
        if triagem_email != 1:
            print("E-mail inválido")
            email = str(input("Digite novamente seu e-mail: "))
        else:
            break
        
    senha = input("Digite sua senha: ")
    while True:
        classificacao = validacao.avaliar_senha(senha)
        if classificacao == "fraca" or classificacao == "media":
            print("Senha fraca")
            senha = input("Digite sua senha novamente: ")
        else:
            break

    endereco = input("Digite o endereço: ")

    nomes.append(nome)
    emails.append(email)
    senhas.append(senha)
    enderecos.append(endereco)

    print("Cadastro realizado com sucesso")