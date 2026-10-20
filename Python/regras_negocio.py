
usuarios = []
clientes = []
imoveis = []
ambientes = []
projetos = []
propostas = []


def buscar_por_id(lista, identificador):
    for item in lista:
        if item["id"] == identificador:
            return item
    return None


def cadastrar_usuario(email, perfil):
    perfis_validos = ["arquiteto", "tecnico", "morador"]
    email = email.strip().lower()
    perfil = perfil.strip().lower()
    if email == "":
        print("Informe o e-mail do usuário.")
        return False
    if perfil not in perfis_validos:
        print("Perfil inválido. Use arquiteto, tecnico ou morador.")
        return False
    for usuario in usuarios:
        if usuario["email"] == email:
            print("E-mail já cadastrado.")
            return False
    usuarios.append({"email": email, "perfil": perfil})
    print("Usuário cadastrado.")
    return True


def usuario_tem_permissao(usuario, perfis_permitidos):
    if usuario is None:
        print("Acesso negado: usuário não identificado.")
        return False
    if usuario.get("perfil") not in ["arquiteto", "tecnico", "morador"]:
        print("Acesso negado: perfil inválido.")
        return False
    if usuario["perfil"] not in perfis_permitidos:
        print("Acesso negado para este perfil.")
        return False
    return True


def projeto_autorizado(usuario, projeto):
    if usuario is None or projeto is None:
        print("Usuário ou projeto não encontrado.")
        return False
    if usuario["email"] in projeto["usuarios_autorizados"]:
        return True
    print("Usuário não autorizado neste projeto.")
    return False


def autorizar_usuario_projeto(usuario, projeto_id, email_usuario):
    if not usuario_tem_permissao(usuario, ["arquiteto"]):
        return False
    projeto = buscar_por_id(projetos, projeto_id)
    if projeto is None or not projeto_autorizado(usuario, projeto):
        return False
    email_usuario = email_usuario.strip().lower()
    if email_usuario == "":
        print("Informe o e-mail do usuário a autorizar.")
        return False
    usuario_cadastrado = False
    for item in usuarios:
        if item["email"] == email_usuario:
            usuario_cadastrado = True
    if not usuario_cadastrado:
        print("Cadastre o usuário antes de autorizá-lo.")
        return False
    if email_usuario in projeto["usuarios_autorizados"]:
        print("Usuário já está autorizado neste projeto.")
        return False
    projeto["usuarios_autorizados"].append(email_usuario)
    print("Usuário autorizado no projeto.")
    return True


def cadastrar_cliente(usuario, cliente_id, nome):
    if not usuario_tem_permissao(usuario, ["arquiteto"]):
        return False
    if buscar_por_id(clientes, cliente_id) is not None:
        print("ID de cliente já cadastrado.")
        return False
    if nome.strip() == "":
        print("Informe o nome do cliente.")
        return False
    clientes.append({"id": cliente_id, "nome": nome.strip()})
    print("Cliente cadastrado.")
    return True


def cadastrar_imovel(usuario, imovel_id, cliente_id, endereco):
    if not usuario_tem_permissao(usuario, ["arquiteto"]):
        return False
    if buscar_por_id(imoveis, imovel_id) is not None:
        print("ID de imóvel já cadastrado.")
        return False
    if buscar_por_id(clientes, cliente_id) is None:
        print("Cliente não encontrado; imóvel não cadastrado.")
        return False
    if endereco.strip() == "":
        print("Informe o endereço do imóvel.")
        return False
    imoveis.append({"id": imovel_id, "cliente_id": cliente_id, "endereco": endereco.strip()})
    print("Imóvel cadastrado.")
    return True


def cadastrar_ambiente(usuario, ambiente_id, imovel_id, nome):
    if not usuario_tem_permissao(usuario, ["arquiteto"]):
        return False
    if buscar_por_id(ambientes, ambiente_id) is not None:
        print("ID de ambiente já cadastrado.")
        return False
    if buscar_por_id(imoveis, imovel_id) is None:
        print("Imóvel não encontrado.")
        return False
    if nome.strip() == "":
        print("Informe o nome do ambiente.")
        return False
    ambientes.append({"id": ambiente_id, "imovel_id": imovel_id, "nome": nome.strip()})
    print("Ambiente cadastrado.")
    return True


def cadastrar_projeto(usuario, projeto_id, nome, imovel_id):
    if not usuario_tem_permissao(usuario, ["arquiteto"]):
        return False
    if buscar_por_id(projetos, projeto_id) is not None:
        print("ID de projeto já cadastrado.")
        return False
    if buscar_por_id(imoveis, imovel_id) is None:
        print("Imóvel não encontrado.")
        return False
    if nome.strip() == "":
        print("Informe o nome do projeto.")
        return False
    projetos.append({
        "id": projeto_id,
        "nome": nome.strip(),
        "imovel_id": imovel_id,
        "ambientes": [],
        "dispositivos": [],
        "usuarios_autorizados": [usuario["email"]],
    })
    print("Projeto cadastrado. O arquiteto criador está autorizado.")
    return True


def adicionar_ambiente_projeto(usuario, projeto_id, ambiente_id):
    if not usuario_tem_permissao(usuario, ["arquiteto"]):
        return False
    projeto = buscar_por_id(projetos, projeto_id)
    ambiente = buscar_por_id(ambientes, ambiente_id)
    if projeto is None or ambiente is None:
        print("Projeto ou ambiente não encontrado.")
        return False
    if not projeto_autorizado(usuario, projeto):
        return False
    if ambiente["imovel_id"] != projeto["imovel_id"]:
        print("O ambiente pertence a outro imóvel e não pode ser usado neste projeto.")
        return False
    if ambiente_id in projeto["ambientes"]:
        print("Ambiente já adicionado ao projeto.")
        return False
    projeto["ambientes"].append(ambiente_id)
    print("Ambiente adicionado ao projeto.")
    return True


def adicionar_dispositivo_projeto(usuario, projeto_id, dispositivo_id, nome,
                                  ambiente_id, quantidade, preco_unitario):

    if not usuario_tem_permissao(usuario, ["arquiteto", "tecnico"]):
        return False
    projeto = buscar_por_id(projetos, projeto_id)
    ambiente = buscar_por_id(ambientes, ambiente_id)
    if projeto is None or ambiente is None:
        print("Projeto ou ambiente não encontrado.")
        return False
    if not projeto_autorizado(usuario, projeto):
        return False
    if ambiente_id not in projeto["ambientes"]:
        print("O ambiente não está vinculado ao projeto.")
        return False
    if ambiente["imovel_id"] != projeto["imovel_id"]:
        print("O ambiente pertence a outro imóvel.")
        return False
    if nome.strip() == "":
        print("Informe o nome do dispositivo.")
        return False
    if quantidade <= 0:
        print("A quantidade deve ser maior que zero.")
        return False
    if preco_unitario < 0:
        print("O preço unitário não pode ser negativo.")
        return False
    projeto["dispositivos"].append({
        "id": dispositivo_id,
        "nome": nome.strip(),
        "ambiente_id": ambiente_id,
        "quantidade": quantidade,
        "preco_unitario": preco_unitario,
    })
    print("Dispositivo adicionado ao projeto.")
    return True


def criar_proposta(usuario, proposta_id, projeto_id):
    if not usuario_tem_permissao(usuario, ["arquiteto"]):
        return False
    if buscar_por_id(propostas, proposta_id) is not None:
        print("ID de proposta já cadastrado.")
        return False
    projeto = buscar_por_id(projetos, projeto_id)
    if projeto is None or not projeto_autorizado(usuario, projeto):
        return False
    propostas.append({
        "id": proposta_id,
        "projeto_id": projeto_id,
        "grupo_id": proposta_id,
        "versao": 1,
        "status": "rascunho",
        "itens": [],
        "decisao": None,
    })
    print("Proposta criada.")
    return True


def adicionar_item_proposta(usuario, proposta_id, tipo, descricao, quantidade,
                            preco_unitario, unidade_cobranca=""):
    if not usuario_tem_permissao(usuario, ["arquiteto"]):
        return False
    proposta = buscar_por_id(propostas, proposta_id)
    if proposta is None:
        print("Proposta não encontrada.")
        return False
    projeto = buscar_por_id(projetos, proposta["projeto_id"])
    if not projeto_autorizado(usuario, projeto):
        return False
    if proposta["status"] != "rascunho":
        print("Só é possível alterar uma proposta em rascunho.")
        return False
    if tipo not in ["dispositivo", "servico"]:
        print("O tipo deve ser dispositivo ou servico.")
        return False
    if descricao.strip() == "":
        print("Informe a descrição do item.")
        return False
    if quantidade <= 0:
        print("A quantidade deve ser maior que zero.")
        return False
    if preco_unitario < 0:
        print("O preço unitário deve ser maior ou igual a zero.")
        return False
    if tipo == "servico" and unidade_cobranca.strip() == "":
        print("Informe a unidade de cobrança do serviço (unidade, hora, visita etc.).")
        return False
    proposta["itens"].append({
        "tipo": tipo,
        "descricao": descricao.strip(),
        "quantidade": quantidade,
        "preco_unitario": preco_unitario,
        "unidade_cobranca": unidade_cobranca.strip() if tipo == "servico" else "",
    })
    print("Item adicionado à proposta.")
    return True


def calcular_orcamento(proposta_id):
    proposta = buscar_por_id(propostas, proposta_id)
    if proposta is None:
        print("Proposta não encontrada.")
        return None
    total = 0
    for item in proposta["itens"]:
        total = total + item["quantidade"] * item["preco_unitario"]
    return total


def emitir_proposta(usuario, proposta_id):
    if not usuario_tem_permissao(usuario, ["arquiteto"]):
        return False
    proposta = buscar_por_id(propostas, proposta_id)
    if proposta is None:
        print("Proposta não encontrada.")
        return False
    projeto = buscar_por_id(projetos, proposta["projeto_id"])
    if not projeto_autorizado(usuario, projeto):
        return False
    if proposta["status"] != "rascunho":
        print("A proposta não está em rascunho.")
        return False
    if len(proposta["itens"]) == 0:
        print("Adicione ao menos um item antes de emitir a proposta.")
        return False
    proposta["status"] = "emitida"
    proposta["valor_total"] = calcular_orcamento(proposta_id)
    print("Proposta emitida. Total: R$ " + format(proposta["valor_total"], ".2f"))
    return True


def registrar_decisao_proposta(usuario, proposta_id, decisao):
    if not usuario_tem_permissao(usuario, ["morador"]):
        return False
    proposta = buscar_por_id(propostas, proposta_id)
    if proposta is None:
        print("Proposta não encontrada.")
        return False
    projeto = buscar_por_id(projetos, proposta["projeto_id"])
    if not projeto_autorizado(usuario, projeto):
        return False
    if proposta["status"] != "emitida":
        print("Só é possível decidir uma proposta emitida.")
        return False
    decisao = decisao.strip().lower()
    if decisao not in ["aprovada", "recusada"]:
        print("A decisão deve ser aprovada ou recusada.")
        return False
    proposta["decisao"] = decisao
    proposta["status"] = decisao
    print("Decisão registrada: " + decisao + ".")
    return True


def criar_nova_versao_proposta(usuario, proposta_id, nova_proposta_id):
    if not usuario_tem_permissao(usuario, ["arquiteto"]):
        return False
    proposta_atual = buscar_por_id(propostas, proposta_id)
    if proposta_atual is None:
        print("Proposta não encontrada.")
        return False
    projeto = buscar_por_id(projetos, proposta_atual["projeto_id"])
    if not projeto_autorizado(usuario, projeto):
        return False
    if proposta_atual["status"] not in ["aprovada", "recusada"]:
        print("A versão atual precisa ter uma decisão antes de criar outra versão.")
        return False
    if buscar_por_id(propostas, nova_proposta_id) is not None:
        print("ID da nova proposta já cadastrado.")
        return False
    nova_versao = {
        "id": nova_proposta_id,
        "projeto_id": proposta_atual["projeto_id"],
        "grupo_id": proposta_atual["grupo_id"],
        "versao": proposta_atual["versao"] + 1,
        "status": "rascunho",
        "itens": [],
        "decisao": None,
    }
    for item in proposta_atual["itens"]:
        nova_versao["itens"].append(item.copy())
    propostas.append(nova_versao)
    print("Nova versão criada em rascunho.")
    return True


def propostas_vigentes():
    mais_recentes = {}
    for proposta in propostas:
        grupo_id = proposta["grupo_id"]
        if grupo_id not in mais_recentes:
            mais_recentes[grupo_id] = proposta
        elif proposta["versao"] > mais_recentes[grupo_id]["versao"]:
            mais_recentes[grupo_id] = proposta
    resultado = []
    for grupo_id in mais_recentes:
        resultado.append(mais_recentes[grupo_id])
    return resultado


def calcular_percentual_aprovacao():
    vigentes = propostas_vigentes()
    total_decididas = 0
    total_aprovadas = 0
    for proposta in vigentes:
        if proposta["decisao"] in ["aprovada", "recusada"]:
            total_decididas = total_decididas + 1
            if proposta["decisao"] == "aprovada":
                total_aprovadas = total_aprovadas + 1
    if total_decididas == 0:
        return "Sem dados"
    return total_aprovadas / total_decididas * 100


def consultar_projeto(usuario, projeto_id):
    projeto = buscar_por_id(projetos, projeto_id)
    if projeto is None:
        print("Projeto não encontrado.")
        return None
    if not projeto_autorizado(usuario, projeto):
        return None
    return projeto



def consultar_propostas(usuario, projeto_id):
    projeto = buscar_por_id(projetos, projeto_id)
    if projeto is None:
        print("Projeto não encontrado.")
        return None
    if not projeto_autorizado(usuario, projeto):
        return None

    propostas_do_projeto = []
    for proposta in propostas:
        if proposta["projeto_id"] == projeto_id:
            propostas_do_projeto.append(proposta)
    return propostas_do_projeto
