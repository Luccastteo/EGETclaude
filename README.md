# EGet - Assistente de Financas Pessoais

Seu contador pessoal inteligente. Aplicativo Flutter completo de controle financeiro pessoal com design premium fintech, alertas inteligentes, sincronizacao Firebase e relatorios em PDF.

## Visao Geral

EGet e um aplicativo mobile completo para controle financeiro pessoal que funciona como um contador pessoal inteligente, permitindo ao usuario:

- Registrar gastos e receitas rapidamente (5-10 segundos)
- - Visualizar claramente quanto entrou, saiu e sobrou no mes
  - - Definir um teto mensal de gastos
    - - Criar metas de economia separadas do orcamento mensal
      - - Receber alertas inteligentes e preventivos
        - - Gerar relatorios financeiros em PDF
          - - Funcionar offline-first com sincronizacao na nuvem
           
            - ## Stack Tecnologica
           
            - - **Frontend Mobile**: Flutter (iOS + Android)
              - - **Estado**: Riverpod
                - - **Arquitetura**: Clean Architecture modularizada por feature
                  - - **Backend**: Firebase (Auth, Firestore com cache offline)
                    - - **Notificacoes**: Local Notifications
                      - - **PDF**: Geracao local
                       
                        - ## Paleta de Cores - Fintech Premium
                       
                        - - **Laranja** (#FF6B35): CTAs e destaque principal
                          - - **Azul marinho** (#1E3A5F): Headers
                            - - **Branco + cinzas suaves**: Background
                              - - **Verde sutil** (#10B981): Entradas
                                - - **Vermelho sutil** (#EF4444): Saidas
                                 
                                  - ## Estrutura do Projeto
                                 
                                  - ```
                                    lib/
                                      core/
                                        router/          # Navegacao com GoRouter
                                        services/        # NotificationService, AlertService
                                        theme/           # AppTheme, AppColors
                                      features/
                                        auth/            # Login, Cadastro, Recuperacao de senha
                                        home/            # Dashboard principal
                                        transactions/    # Lancamentos
                                        history/         # Historico
                                        reports/         # Relatorios e graficos
                                        goals/           # Metas de economia
                                        settings/        # Configuracoes
                                        onboarding/      # Primeiro uso
                                    ```

                                    ## Alertas Inteligentes

                                    ### Alertas por Porcentagem do Teto
                                    - 80% - Alerta amarelo
                                    - - 90% - Alerta laranja
                                      - - 100% - Alerta vermelho
                                       
                                        - Disparados apenas uma vez por nivel por mes (sem spam).
                                       
                                        - ### Alertas por Projecao
                                        - ```
                                          media_diaria = gasto_acumulado / dias_passados
                                          projecao = media_diaria x dias_do_mes
                                          Se projecao > teto -> alertar preventivamente
                                          ```

                                          ### Mensagem Personalizavel
                                          Templates com variaveis: `{nome}`, `{percentual}`, `{teto}`, `{gasto_atual}`, `{dias_restantes}`

                                          Exemplo: "Sr. {nome}, voce ja utilizou {percentual} do seu teto mensal."

                                          ## Modelo de Dados (Firestore)

                                          - `users/{userId}` - Dados do usuario
                                          - - `users/{userId}/transactions/{id}` - Transacoes
                                            - - `users/{userId}/categories/{id}` - Categorias
                                              - - `users/{userId}/budgets/{YYYY-MM}` - Orcamentos mensais
                                                - - `users/{userId}/goals/{id}` - Metas de economia
                                                  - - `users/{userId}/notificationLogs/{id}` - Logs de notificacoes
                                                   
                                                    - ## Acessibilidade

                                                    - Contraste AA
                                                    - - Fonte escalavel
                                                      - - Botoes >= 44px
                                                      - Labels para VoiceOver
                                                      - - Sem dependencia de gestos complexos
                                                       
                                                        - ## Como Executar
                                                       
                                                        - ```bash
                                                          # Clone o repositorio
                                                          git clone https://github.com/Luccastteo/EGETclaude.git

                                                          # Entre no diretorio
                                                          cd EGETclaude

                                                          # Instale as dependencias
                                                          flutter pub get

                                                          # Configure o Firebase
                                                          flutterfire configure

                                                          # Execute o app
                                                          flutter run
                                                          ```

                                                          ## Licenca

                                                          Este projeto foi desenvolvido como demonstracao de produto fintech real.
