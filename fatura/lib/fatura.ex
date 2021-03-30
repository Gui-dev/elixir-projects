defmodule Fatura do
  @moduledoc """
    Este módulo executamos funções de fatura
  """

  @doc """
    Ao receber `faturas` retorna um array de faturas
      ## Exemplos
      iex> Fatura.criar_faturas(['Telefone', 'Agua'], [5, 10])
      [
        %Fatura.Conta{fatura: 'Telefone', vencimento: 5},
        %Fatura.Conta{fatura: 'Agua', vencimento: 5},
        %Fatura.Conta{fatura: 'Telefone', vencimento: 10},
        %Fatura.Conta{fatura: 'Agua', vencimento: 10}
      ]
  """
  def criar_faturas(faturas, vencimentos) do
    for vencimento <- vencimentos, fatura <- faturas do
      %Fatura.Conta{fatura: fatura, vencimento: vencimento}
    end
  end

  @doc """
    Ao receber `faturas` e `quantidades` retorna um array com as quantidades passada
      ## Exemplos
      iex> faturas = Fatura.criar_faturas(['Telefone', 'Agua'], [5, 10])
      iex> Fatura.faturas_a_pagar(faturas, 1)
      {
        [%Fatura.Conta{fatura: 'Telefone', vencimento: 5}],
        [
          %Fatura.Conta{fatura: 'Agua', vencimento: 5},
          %Fatura.Conta{fatura: 'Telefone', vencimento: 10},
          %Fatura.Conta{fatura: 'Agua', vencimento: 10}
        ]
      }
  """
  def faturas_a_pagar(faturas, quantidades) do
    Enum.split(faturas, quantidades)
  end

  @doc """
    Ao receber o `nome_arquivo` e `faturas` salvar e retornar um :ok
      ## Exemplo
      iex> faturas = Fatura.criar_faturas(['Telefone', 'Agua'], [5, 10])
      iex> Fatura.save(faturas, 'nome_arquivo')
      :ok
  """
  def save(faturas, nome_arquivo) do
    binary = :erlang.term_to_binary(faturas)
    File.write!(nome_arquivo, binary)
  end

  @doc """
    Ao receber `nome_arquivo` retorna o arquivo
      ##Exemplos
      iex> Fatura.load('nome_arquivo')
  """
  def load(nome_arquivo) do
    { status, file } = File.read(nome_arquivo)

    case status do
      :ok -> :erlang.binary_to_term file
      :error -> "Não foi possível carregar o arquivo"
    end

  end

  @doc """
    Ao receber dados para gerar fatura, deve ordenar e salvar em um arquivo
      ## Exemplos
      iex> faturas = Fatura.criar_faturas(['Telefone', 'Agua'], [5, 10])
      iex> Fatura.pagar_uma_fatura(faturas, [5, 10], 1, 'nome_arquivo')
      iex> :ok
  """
  def pagar_uma_fatura(faturas, vencimento, quantidade, nome_arquivo) do
    criar_faturas(faturas, vencimento)
    |> ordena_fatura
    |> faturas_a_pagar(quantidade)
    |> save(nome_arquivo)
  end

  @doc """
    Ao receber `fatura` retorna um array de faturas ordenado
      ##Exemplos
      iex> faturas = Fatura.criar_faturas(['Telefone', 'Agua'], [5, 10])
      iex> Fatura.ordena_fatura(faturas)
      [
        %Fatura.Conta{fatura: 'Agua', vencimento: 5},
        %Fatura.Conta{fatura: 'Agua', vencimento: 10},
        %Fatura.Conta{fatura: 'Telefone', vencimento: 5},
        %Fatura.Conta{fatura: 'Telefone', vencimento: 10}
      ]
  """
  def ordena_fatura(faturas) do
    Enum.sort(faturas)
  end

  @doc """
    Ao receber `faturas` e um elemento de `fatura` retorna se ele existe ou não
      ## Exemplos
      iex> faturas = Fatura.criar_faturas(['Telefone', 'Agua'], [5, 10])
      iex> Fatura.fatura_existe?(faturas, %Fatura.Conta{fatura: 'Telefone', vencimento: 5})
      iex> true
  """
  def fatura_existe?(faturas, fatura) do
    Enum.member?(faturas, fatura)
  end
end
