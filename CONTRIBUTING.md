# Guia de Contribuição para o RecifeMemo

Obrigado pelo interesse em contribuir para o RecifeMemo! Este documento fornece diretrizes para contribuir com o projeto.

## Como Contribuir

### Reportando Bugs

1. Verifique se o bug já não foi reportado na seção de Issues.
2. Use o template de bug report para criar uma nova issue.
3. Inclua passos detalhados para reproduzir o problema.
4. Adicione capturas de tela, se possível.
5. Descreva o comportamento esperado e o comportamento atual.

### Sugerindo Melhorias

1. Verifique se a melhoria já não foi sugerida na seção de Issues.
2. Use o template de feature request para criar uma nova issue.
3. Descreva claramente a melhoria e o valor que ela trará para os usuários.
4. Se possível, inclua mockups ou diagramas.

### Contribuindo com Código

1. Faça um fork do repositório.
2. Crie uma branch para sua feature ou correção:
   ```bash
   git checkout -b feature/nome-da-feature
   ```
   ou
   ```bash
   git checkout -b fix/nome-do-bug
   ```
3. Faça suas alterações seguindo as convenções de código do projeto.
4. Adicione testes para suas alterações, se aplicável.
5. Execute os testes para garantir que tudo está funcionando:
   ```bash
   npm test
   ```
6. Faça commit das suas alterações seguindo as convenções de commit:
   ```bash
   git commit -m "feat: adiciona nova funcionalidade"
   ```
   ou
   ```bash
   git commit -m "fix: corrige problema com autenticação"
   ```
7. Faça push para o seu fork:
   ```bash
   git push origin feature/nome-da-feature
   ```
8. Abra um Pull Request para a branch principal do projeto.

## Convenções de Código

### JavaScript/TypeScript

- Use TypeScript para todo o código novo.
- Siga o estilo de código definido no ESLint e Prettier.
- Documente funções e componentes complexos.
- Mantenha os componentes pequenos e focados em uma única responsabilidade.

### CSS/Tailwind

- Use classes do Tailwind CSS para estilização.
- Evite CSS inline, exceto quando necessário.
- Mantenha a consistência com o design system existente.

### SQL

- Documente todas as funções SQL.
- Use nomes descritivos para tabelas, colunas e funções.
- Adicione comentários para explicar consultas complexas.

## Processo de Pull Request

1. Preencha o template de Pull Request com todas as informações necessárias.
2. Vincule o PR a issues relacionadas.
3. Certifique-se de que todos os testes estão passando.
4. Aguarde a revisão de pelo menos um mantenedor.
5. Faça as alterações solicitadas, se necessário.
6. Uma vez aprovado, seu PR será mesclado à branch principal.

## Configuração do Ambiente de Desenvolvimento

Consulte o arquivo README.md para instruções detalhadas sobre como configurar o ambiente de desenvolvimento.

## Recursos Adicionais

- [Documentação do Supabase](https://supabase.io/docs)
- [Documentação do React](https://reactjs.org/docs)
- [Documentação do Tailwind CSS](https://tailwindcss.com/docs)
- [Documentação do TypeScript](https://www.typescriptlang.org/docs)

## Código de Conduta

Ao contribuir para este projeto, você concorda em seguir nosso [Código de Conduta](CODE_OF_CONDUCT.md).

## Dúvidas?

Se você tiver alguma dúvida sobre como contribuir, sinta-se à vontade para abrir uma issue com a tag "question".

Agradecemos sua contribuição para tornar o RecifeMemo melhor! 