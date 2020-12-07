//
//  CodeViewProtocol.swift
//  Rick and Morty
//
//  Created by Cleverson Luiz Correia de Souza on 04/12/20.
//  Copyright © 2020 James. All rights reserved.
//

protocol ViewCodeProtocol {
    func buildHierarchy()
    func setupConstraints()
    func additionalSetup()
    func setupView()
}

extension ViewCodeProtocol {
    func setupView() {
        self.buildHierarchy()
        self.setupConstraints()
        self.additionalSetup()
    }
}
