function love.load()

	love.physics.setMeter(64)
	mundo = love.physics.newWorld(0,0, true)
	---mundo:setCallbacks(beginContact)
	----variaveis de controle de tela -----
	startmenu = true
	startjogo = false
	vascocampeao = false
	flamengocampeao = false
	
	---carrega menu --
	menu = love.graphics.newImage("imagens/menu.png")
	
	botaoplay = {}
	botaoplay.imagem = love.graphics.newImage("imagens/botaostart.png")
	botaoplay.x = 600
	botaoplay.y = 450
	botaoplay.w = botaoplay.imagem:getWidth()
	botaoplay.h = botaoplay.imagem:getHeight()
	
	----carrega tela de vasco campeao
	vascocamp = love.graphics.newImage("imagens/vascocamp.png")
	----carrega tela de flamengo campeao
	flamengocamp = love.graphics.newImage("imagens/flamengocamp.png")
	---- carregando musicas -------
	--musica menu
	menumusic = love.audio.newSource("musicas/musicamenu.mp3","stream")
	menumusic:setLooping(true)
	love.audio.play(menumusic) 
	love.audio.setVolume(5)
	---som da torcida
	torcida = love.audio.newSource("musicas/torcida.mp3","stream")
	torcida:setLooping(true)
	love.audio.setVolume(4)
	---grito do gol
	gol = love.audio.newSource("musicas/gol.mp3","stream")
	gol:setLooping(false)
	---apito de bola rolando
	apito = love.audio.newSource("musicas/apito.mp3","stream")
	apito:setLooping(false)
	---hino vasco
	hinovasco = love.audio.newSource("musicas/hinovasco.mp3","stream")
	hinovasco:setLooping(true)
	---hino flamengo
	hinoflamengo = love.audio.newSource("musicas/hinoflamengo.mp3","stream")
	hinoflamengo:setLooping(true)
	
	
	
	-----carrega cenario do jogo ---
	campo = love.graphics.newImage("imagens/campo.png")

	
	---criando placar---
	placarEsquerda = 0
	placarDireita = 0
	

	---bola dados---]
	
	bola = {}                                                                                            -------MEUJOGO-------
	bolaimg = love.graphics.newImage("imagens/bola.png")
	bola.width = bolaimg:getWidth() ---- detecta largura ---
	bola.height = bolaimg:getHeight() ----detecta altura- ---
	bola.body = love.physics.newBody(mundo, 500,300,"dynamic")
	bola.shape = love.physics.newCircleShape(20)
	bola.fixture = love.physics.newFixture(bola.body,bola.shape,1)
	bola.fixture:setRestitution(1.4)
	bola.x = bola.body:getX()
	bola.y = bola.body:getY()
	bola.fixture:setUserData("bola")

	

	--barras dados--
	barraUm = {}
	barraUm.body = love.physics.newBody(mundo,25,300,"dynamic") ---- posição da barra no jogo
	barraUm.shape = love.physics.newRectangleShape(10,200)    ----
	barraUm.fixture = love.physics.newFixture(barraUm.body,barraUm.shape,1)
	barraUm.body:setInertia(0)    --- inercia 0 para a barra nao girar ---
	barraUm.x = barraUm.body:getX()
	barraUm.y = barraUm.body:getY()
	barraUm.w = 5
	barraUm.h = 100
	barraUm.fixture:setUserData("barraUm")
	barraUm.body:setMass(2)

	barraDois = {}
	barraDois.body = love.physics.newBody(mundo,995,300,"dynamic")
	barraDois.shape = love.physics.newRectangleShape(10,200)
	barraDois.fixture = love.physics.newFixture(barraDois.body,barraDois.shape,1)
	barraDois.body:setInertia(0)
	barraDois.x = barraDois.body:getX()
	barraDois.y = barraDois.body:getY()
	barraDois.w = 5
	barraDois.h = 100
	barraDois.fixture:setUserData("barraDois")
	barraDois.body:setMass(2)
	-----bordas---------

	bordascima={}
	bordascima.b=love.physics.newBody(mundo, 500,14, "static") 
    bordascima.s = love.physics.newRectangleShape(1000,0)
	bordascima.f = love.physics.newFixture(bordascima.b, bordascima.s)
	bordascima.b:setMass(10)

    bordasbaixo={}
	bordasbaixo.b=love.physics.newBody(mundo, 500 ,586, "static") 
	bordasbaixo.s = love.physics.newRectangleShape(1000,0)
	bordasbaixo.f = love.physics.newFixture(bordasbaixo.b, bordasbaixo.s)
	bordasbaixo.b:setMass(10)
   
	
end


function love.update(dt)

	mundo:update(dt)
	
	----controle das musicas ---
	if startmenu == false and startjogo == true then 
		menumusic:stop()
		love.audio.play(torcida)
	end
	
	
	---controles barra 1----
	
	if love.keyboard.isDown("s") then
		barraUm.body:applyForce(0,19000)
	end
	if love.keyboard.isDown("w") then
		barraUm.body:applyForce(0,-19000)
	end
	
	
	
	---controles barra 2----
	if love.keyboard.isDown("up") then
		barraDois.body:applyForce(0,-24000)
	elseif love.keyboard.isDown("down") then
		barraDois.body:applyForce(0,24000)
	end
	
	-----pontapé inicial
	if love.keyboard.isDown("space") then
		bola.body:setLinearVelocity(-700,0) 
		love.audio.play(apito)
	end	


	---fazendo com q a barra fique parada quando entrar em colisão com a bola-----
					------ para a barra da esquerda----
				
	function parabarra1()
	barraUm.body:setX(25)
	barraUm.body:setY(barraUm.body:getY())
	barraUm.body:setLinearVelocity(0,barraUm.body:getLinearVelocity())
	end
	parabarra1()
	
	               ------ para a barra da direita----
	function parabarra2()
	barraDois.body:setX(975)
	barraDois.body:setY(barraDois.body:getY())
	barraDois.body:setLinearVelocity(0,barraDois.body:getLinearVelocity())
	end
	parabarra2()
	
	
	----- deixa a bola no meio da tela depois do gol-------
	------ tabem adiciona o gol ao placar --------
	if bola.body:getX() <= -15 then
		placarDireita = placarDireita + 1
    	resetaBola()
		love.audio.play(gol)
	end
	
	if bola.body:getX() >= 1015 then
		placarEsquerda = placarEsquerda + 1
    	resetaBola()
		love.audio.play(gol)
	end
	
	function resetaBola()
	bola.body:setX(500)    
	bola.body:setY(300)
	bola.body:setLinearVelocity(0,0)-- Deixa a bola parada
	end
	
	---- condições de vitoria
	if placarEsquerda == 3 then
		startjogo = false
		vascocampeao = true
	elseif placarDireita == 3 then
		startjogo= false
		flamengocampeao = true
	end
	
end

function drawvascocamp()
	love.graphics.draw(vascocamp,0,0)
	love.audio.play(hinovasco)
end

function drawflamengocamp()
	love.graphics.draw(flamengocamp,0,0)
	love.audio.play(hinoflamengo)
end

function drawmenu()
	love.graphics.draw(menu,0,0)
	love.graphics.draw(botaoplay.imagem,botaoplay.x,botaoplay.y)
end
function drawjogo()

	love.graphics.draw(campo,0,0)
	--desenha barras----
	love.graphics.polygon("fill", barraDois.body:getWorldPoints(barraDois.shape:getPoints() ) )
	love.graphics.polygon("fill", barraUm.body:getWorldPoints(barraUm.shape:getPoints() ) )
	-----desenha bola ----
	----love.graphics.circle("fill",bola.body:getX(), bola.body:getY(), bola.shape:getRadius())
	love.graphics.draw(bolaimg, bola.body:getX() - 20, bola.body:getY() - 22)
	love.graphics.circle("line",bola.body:getX(), bola.body:getY(), bola.shape:getRadius(),50,5)
	--------- desneha borda de cima=---------------
	love.graphics.polygon("line", bordascima.b:getWorldPoints(bordascima.s:getPoints()))
------------------------desenha borda de baixo----------------
	love.graphics.polygon("line", bordasbaixo.b:getWorldPoints(bordasbaixo.s:getPoints()))
	
	
	-----desenhando placar---
	love.graphics.print(placarEsquerda,470,30,0,2,3)
	love.graphics.print(placarDireita,530,30,0,2,3)
	
	
end
function love.mousepressed(x,y,button)
	if  startmenu and button==1 and x>=botaoplay.x and x < botaoplay.x + botaoplay.w and y >=botaoplay.y and y < botaoplay.y + botaoplay.h then
		startjogo=true
		startmenu=false
	end
end
function love.draw()
	if startmenu then
		drawmenu()
	end
	if startjogo then
		drawjogo()
	end
	if flamengocampeao then
		drawflamengocamp()
	end
	if vascocampeao then
		drawvascocamp()
	end	
	
	
end