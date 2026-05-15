import pytest
from app import app  # Importa o seu Flag Service

# Cria um "cliente falso" para simular acessos ao seu serviço
@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

# 1. Teste de Sanidade 
def test_pipeline_esta_rodando():
    # Se 1 + 1 não for 2, o mundo acabou e a pipeline tem que quebrar mesmo
    assert 1 + 1 == 2

# 2. Teste de Rota Básica
def test_rota_principal_nao_quebra(client):
    # O cliente falso tenta acessar a raiz do seu serviço
    resposta = client.get('/')
    
    # Ele verifica se o servidor respondeu sem dar erro de código (Erro 500)
    # Se retornar 200 (OK) ou 404 (Não Encontrado), o serviço está no ar!
    assert resposta.status_code in [200, 404]